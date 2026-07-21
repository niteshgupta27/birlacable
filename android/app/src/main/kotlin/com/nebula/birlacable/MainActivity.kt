package com.nebula.birlacable

import android.Manifest
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.os.Handler
import android.os.Looper
import android.provider.CallLog
import android.provider.Settings
import android.telephony.PhoneStateListener
import android.telephony.TelephonyManager
import android.util.Log
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.nebula.birlacable/call"
    private val CHANNEL1 = "com.nebula.birlacable/permissions"

    private var isOutgoingCall: Boolean = false
    private var hasOutgoingCallBeenAnswered: Boolean = false

    private val CALL_PHONE_PERMISSION = 1
    private lateinit var telephonyManager: TelephonyManager
    private var startTime: Long = 0
    private val PERMISSION_REQUEST_CODE = 1001
    private val ALL_FILES_ACCESS_REQUEST_CODE = 1002
    private var handler: Handler? = null
    private var checkForAnswerRunnable: Runnable? = null
    private var result: MethodChannel.Result? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        telephonyManager = getSystemService(Context.TELEPHONY_SERVICE) as TelephonyManager

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "makeCall" -> {
                    val phoneNumber = call.argument<String>("number")
                    if (phoneNumber != null) {
                        makePhoneCall(phoneNumber)
                        result.success(null)
                    } else {
                        result.error("INVALID_INPUT", "Phone number not provided", null)
                    }
                }

                "startListening" -> {
                    startCallStateListener()
                    result.success("Listening for call state changes")
                }

                else -> result.notImplemented()
            }
        }

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL1
        ).setMethodCallHandler { call, result ->
            if (call.method == "requestCallLogPermission" || call.method == "requestPermissions") {
                this.result = result
                requestAllAppPermissions()
            } else {
                result.notImplemented()
            }
        }
    }

    private fun makePhoneCall(phoneNumber: String) {
        if (ContextCompat.checkSelfPermission(
                this,
                Manifest.permission.CALL_PHONE
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.CALL_PHONE),
                CALL_PHONE_PERMISSION
            )
        } else {
            val intent = Intent(Intent.ACTION_CALL)
            intent.data = Uri.parse("tel:$phoneNumber")
            startActivity(intent)
            startCallStateListener()
        }
    }

    private fun startCallStateListener() {
        telephonyManager.listen(object : PhoneStateListener() {
            @Deprecated("Deprecated in Java")
            override fun onCallStateChanged(state: Int, phoneNumber: String?) {
                super.onCallStateChanged(state, phoneNumber)
                when (state) {
                    TelephonyManager.CALL_STATE_RINGING -> {
                        Log.d("CALL_STATE", "Incoming call from $phoneNumber")
                        startTime = System.currentTimeMillis()
                    }

                    TelephonyManager.CALL_STATE_OFFHOOK -> {
                        if (!isOutgoingCall) {
                            Log.d("CALL_STATE", "Outgoing call started")
                            isOutgoingCall = true
                            startTime = System.currentTimeMillis()
                        }
                    }

                    TelephonyManager.CALL_STATE_IDLE -> {
                        if (startTime > 0) {
                            val duration = (System.currentTimeMillis() - startTime) / 1000
                            Log.d("CALL_STATE", "Call ended. Duration: $duration seconds")
                            handler = Handler(Looper.getMainLooper())
                            checkForAnswerRunnable = Runnable {
                                accessCallLogs()
                            }
                            handler?.postDelayed(checkForAnswerRunnable!!, 3000)

                            startTime = 0
                        } else {
                            Log.d("CALL_STATE", "Call ended")
                        }
                        isOutgoingCall = false
                        hasOutgoingCallBeenAnswered = false
                    }
                }
            }
        }, PhoneStateListener.LISTEN_CALL_STATE)
    }

    private fun sendCallStateToFlutter(
        state: String,
        phoneNumber: String?,
        duration: Long? = null,
        type: String?,
        date: String?
    ) {
        val arguments = if (duration != null) {
            mapOf(
                "state" to state,
                "number" to phoneNumber,
                "duration" to duration,
                "type" to type,
                "Date" to date
            )
        } else {
            mapOf("state" to state, "number" to phoneNumber, "type" to type, "Date" to date)
        }
        flutterEngine?.dartExecutor?.binaryMessenger?.let {
            MethodChannel(it, CHANNEL).invokeMethod("callStateChanged", arguments)
        }
    }

    private fun accessCallLogs() {
        val cursor = contentResolver.query(
            CallLog.Calls.CONTENT_URI,
            null, null, null, "${CallLog.Calls.DATE} DESC"
        )

        if (cursor != null && cursor.moveToFirst()) {
            val numberIndex = cursor.getColumnIndex(CallLog.Calls.NUMBER)
            val durationIndex = cursor.getColumnIndex(CallLog.Calls.DURATION)
            val dateIndex = cursor.getColumnIndex(CallLog.Calls.DATE)
            val typeIndex = cursor.getColumnIndex(CallLog.Calls.TYPE)

            if (numberIndex != -1 && durationIndex != -1 && dateIndex != -1 && typeIndex != -1) {
                val phoneNumber = cursor.getString(numberIndex)
                val callDuration = cursor.getString(durationIndex).toLong()
                val callDate = cursor.getString(dateIndex)
                val type = cursor.getString(typeIndex)
                Log.d(
                    "CALL_LOG",
                    "Phone Number: $phoneNumber, Duration: $callDuration seconds, $callDate"
                )
                sendCallStateToFlutter("Calllog", phoneNumber, callDuration, type, callDate)
            }
        }
        cursor?.close()
    }

    private fun requestAllAppPermissions() {
        val permissions = mutableListOf(
            Manifest.permission.CALL_PHONE,
            Manifest.permission.READ_PHONE_STATE,
            Manifest.permission.READ_CALL_LOG,
            Manifest.permission.CAMERA,
            Manifest.permission.RECORD_AUDIO,
            Manifest.permission.ACCESS_FINE_LOCATION,
            Manifest.permission.ACCESS_COARSE_LOCATION
        )

        val permissionsToRequest = permissions.filter {
            ContextCompat.checkSelfPermission(this, it) != PackageManager.PERMISSION_GRANTED
        }.toMutableList()

        var allFilesAccessGranted = true
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            if (!Environment.isExternalStorageManager()) {
                allFilesAccessGranted = false
                val intent = Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION)
                val uri = Uri.fromParts("package", packageName, null)
                intent.data = uri
                startActivityForResult(intent, ALL_FILES_ACCESS_REQUEST_CODE)
                return
            }
        } else {
            if (ContextCompat.checkSelfPermission(
                    this,
                    Manifest.permission.READ_EXTERNAL_STORAGE
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                permissionsToRequest.add(Manifest.permission.READ_EXTERNAL_STORAGE)
            }
            if (ContextCompat.checkSelfPermission(
                    this,
                    Manifest.permission.WRITE_EXTERNAL_STORAGE
                ) != PackageManager.PERMISSION_GRANTED
            ) {
                permissionsToRequest.add(Manifest.permission.WRITE_EXTERNAL_STORAGE)
            }
        }

        if (permissionsToRequest.isNotEmpty()) {
            ActivityCompat.requestPermissions(
                this,
                permissionsToRequest.toTypedArray(),
                PERMISSION_REQUEST_CODE
            )
        } else if (allFilesAccessGranted) {
            flutterEngine?.dartExecutor?.binaryMessenger?.let {
                MethodChannel(it, CHANNEL1).invokeMethod("permissionsResult", "Granted")
            }
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)

        if (requestCode == PERMISSION_REQUEST_CODE) {
            val deniedPermissions = permissions.filterIndexed { index, _ ->
                grantResults[index] != PackageManager.PERMISSION_GRANTED
            }

            val isAllFilesAccessGranted = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                Environment.isExternalStorageManager()
            } else {
                ContextCompat.checkSelfPermission(
                    this,
                    Manifest.permission.READ_EXTERNAL_STORAGE
                ) == PackageManager.PERMISSION_GRANTED &&
                        ContextCompat.checkSelfPermission(
                            this,
                            Manifest.permission.WRITE_EXTERNAL_STORAGE
                        ) == PackageManager.PERMISSION_GRANTED
            }

            if (deniedPermissions.isEmpty() && isAllFilesAccessGranted) {
                flutterEngine?.dartExecutor?.binaryMessenger?.let {
                    MethodChannel(it, CHANNEL1).invokeMethod("permissionsResult", "Granted")
                }
            } else {
                val allDenied = deniedPermissions.toMutableList()
                if (!isAllFilesAccessGranted && Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                    allDenied.add("MANAGE_EXTERNAL_STORAGE")
                }
                flutterEngine?.dartExecutor?.binaryMessenger?.let {
                    MethodChannel(it, CHANNEL1).invokeMethod(
                        "permissionsResult",
                        "Denied: ${allDenied.joinToString(", ")}"
                    )
                }
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == ALL_FILES_ACCESS_REQUEST_CODE) {
            requestAllAppPermissions()
        }
    }
}

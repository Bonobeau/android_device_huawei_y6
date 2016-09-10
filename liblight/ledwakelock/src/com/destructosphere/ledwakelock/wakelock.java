package com.destructosphere.ledwakelock;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import android.annotation.SuppressLint;
import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Handler;
import android.os.IBinder;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;

public class wakelock extends Service {

	boolean running;
	boolean cancel;
	PowerManager powerManager;
	WakeLock wakeLock;
	StringBuilder active = new StringBuilder();
	private Handler handler = new Handler();
	SharedPreferences sharedpreferences;
	public int timeout;
	public long milliSeconds;
	
    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
    	if (running)
    	{
    		cancel = true;
    	}
    	running = true;
		powerManager = (PowerManager) getSystemService(POWER_SERVICE);
		wakeLock = powerManager.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK,
		       "NotificationLeds");
		handler.postDelayed(begin, 0);
		return startId;
    }
    
    private Runnable runnable = new Runnable() {
    	   @Override
    	   public void run() {
    		   if (cancel){
	        		cancel = false;
	        		if (wakeLock.isHeld()){
	        		    wakelockset(0);
	        		}
	            }else{
    		        active.setLength(0);
    		        try {
    			        String line = "lights.notification"; 
    	                Process process = Runtime.getRuntime().exec("getprop " + line);
    	                BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
    	            
    	                while ((line = in.readLine()) != null) {
    	                    active.append(line);
    	                }
    	            } catch (IOException e) {
    				    e.printStackTrace();
    			    }

	            	    if (active.toString().equals("on") && wakeLock.isHeld()){
	    	    		    handler.postDelayed(this, 4000);
	    	            }else if (wakeLock.isHeld()){
	    	        		wakelockset(0);
	    	        		stopSelf();
	    	            }else{
	    	            	stopSelf();
	    	            }
	                }    	    	
    	       }
    	};
    
	private Runnable begin = new Runnable()
	{
		@Override
		public void run()
		{
			get();
			wakelockset(1);
		}
	};
	
	@SuppressLint("Wakelock") public void wakelockset(int status)
	{

		
		if (status == 1)
		{
		    if (timeout > 0){
				if (timeout == 8){
					wakeLock.acquire();
				}else{
					wakeLock.acquire(milliSeconds);
				}
			}
	    	handler.postDelayed(runnable, 6000);
		}else if (status == 0){
	    	wakeLock.release();
		}


	}
	
	public void get()
	{		
		sharedpreferences = getSharedPreferences("shared_prefs", Context.MODE_PRIVATE);
    	           
            if (sharedpreferences.contains("timeout")){
        	    timeout = sharedpreferences.getInt("timeout", 0);
            }else{
        	    timeout = 0;
        	}
	    if (timeout == 1){
		    milliSeconds = 60000L;
    	}else if (timeout == 2){
	    	milliSeconds = 120000L;
	    }else if (timeout == 3){
		    milliSeconds = 300000L;
    	}else if (timeout == 4){
	    	milliSeconds = 600000L;
	    }else if (timeout == 5){
		    milliSeconds = 1800000L;
	    }else if (timeout == 6){
		    milliSeconds = 3600000L;
	    }else if (timeout == 7){
		    milliSeconds = 7200000L;
	    }
	}

	@Override
	public IBinder onBind(Intent arg0) {
		// TODO Auto-generated method stub
		return null;
	}
}

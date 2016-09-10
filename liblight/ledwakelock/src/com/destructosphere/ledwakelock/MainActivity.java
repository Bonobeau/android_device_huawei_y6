package com.destructosphere.ledwakelock;


import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.app.Activity;
import android.app.AlertDialog;
import android.os.Bundle;
import android.view.View;
import android.widget.Spinner;


import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;


public class MainActivity extends Activity {

	SharedPreferences sharedpreferences;
	long milliSeconds;
	public boolean firstRun;
	boolean alert;
	String alertText;
	int timeout;
	public String idName = "ro.product.model";
	StringBuilder total = new StringBuilder();
	public boolean checkDaemon(){
	    File file = new File("/system/bin/lightsd");
	    return file.exists();
	}
	
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
           	if (checkSys(idName) == false){
           		alert = true;
                alertText = getString(R.string.alert1);
            }
            if (checkDaemon() == false){
        	    if (alert == true){
        		    alertText = getString(R.string.alert2);
        	    }else{
        	    	alert = true;
                    alertText = getString(R.string.alert3);
                }
        	if (alert == true){
        	    alert();
            }
        }
            setting("get", 0);
            settingToSpinner();
    }

    
    @Override
    protected void onResume() {
        super.onResume();
        
    }
   
    public boolean checkSys(String line){
    	try {
            Process process = Runtime.getRuntime().exec("getprop " + line);
            BufferedReader in = new BufferedReader(new InputStreamReader(process.getInputStream()));
            
            while ((line = in.readLine()) != null) {
                total.append(line);
            }
        } catch (IOException e) {
			e.printStackTrace();
		}
    	if (total.toString().equals("y6")){
        return true;
        }
        else{
        return false;
        }
    }
    
    public void setting(String task, int val){
    	sharedpreferences = getSharedPreferences("shared_prefs",Context.MODE_PRIVATE);
    	if (task == "get"){            
            if (sharedpreferences.contains("timeout")){
        	    timeout = sharedpreferences.getInt("timeout", 0);
            }else{
        	    timeout = 0;
        	    putvalue(timeout);
        	}
        }else if (task == "set"){
        	putvalue(val);
        }
    }
    
    public void putvalue(int value)
    {
    	final Editor editor = sharedpreferences.edit();
    	editor.putInt("timeout", value);
    	editor.apply();
    }
    
    
    public void settingToSpinner()
    {
        	Spinner mySpinner = (Spinner) findViewById(R.id.spinner1);
        	try {
            	mySpinner.setSelection(timeout);
            	} catch (Exception e) {
        			e.printStackTrace();
        		}
    	
    }
    
  public void alert()
    {
    	AlertDialog.Builder builder1 = new AlertDialog.Builder(MainActivity.this);
    	builder1.setMessage(alertText);
    	builder1.setCancelable(true);

    	builder1.setPositiveButton(
    	    "Ok",
    	    new DialogInterface.OnClickListener() {
    	        public void onClick(DialogInterface dialog, int id) {
    	            dialog.cancel();
    	        }
    	    });

    	AlertDialog alert11 = builder1.create();
    	alert11.show();
    }
  public void apply(View view){
	  Spinner mySpinner = (Spinner) findViewById(R.id.spinner1);
	  int i = (mySpinner.getSelectedItemPosition());
	  setting("set", i);
  }
 }

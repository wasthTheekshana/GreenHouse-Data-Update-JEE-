/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.theekshana.dao;

import com.theekshana.model.SensorData;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author wasat
 */
public class SenorDataDao {
    
    
    private static List<SensorData> sensorDataList;
    
    static {
    sensorDataList = new ArrayList<>();
    }

    public static List<SensorData> getSensorDataList() {
        return sensorDataList;
    }
    
    public static void addData(SensorData data){
        if (data != null) {
            sensorDataList.add(data);
        }
    }
    
}

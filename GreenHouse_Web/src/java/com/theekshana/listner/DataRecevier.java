/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.theekshana.listner;

import com.google.gson.Gson;
import com.theekshana.dao.SenorDataDao;
import com.theekshana.model.SensorData;
import java.util.Timer;
import java.util.TimerTask;
import javax.jms.JMSException;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSession;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.QueueReceiver;
import javax.jms.Session;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/**
 *
 * @author wasat
 */
@WebListener
public class DataRecevier implements ServletContextListener
{

    @Override
    public void contextInitialized(ServletContextEvent sce) {
         try {
            InitialContext context = new InitialContext();
            QueueConnectionFactory factory = (QueueConnectionFactory) context.lookup("GreenHouse-Queue");
            Queue queue = (Queue) context.lookup("GreenHouse_Destinaion");
            QueueConnection connection = factory.createQueueConnection();
            connection.start();
            QueueSession session = connection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
            run(factory, queue,session);
        } catch (NamingException ex) {
            Logger.getLogger(DataRecevier.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JMSException ex) {
            Logger.getLogger(DataRecevier.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    
        private void run(QueueConnectionFactory factory, Queue queue,QueueSession session) {
        Timer timer = new Timer();
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                try {
                    QueueReceiver receiver = session.createReceiver(queue);
                    receiver.setMessageListener(new MessageListener() {
                        @Override
                        public void onMessage(Message e) {
                            try {
                                System.out.println("------------[" + e.getBody(String.class) + "]-----------");
                                Gson gson = new Gson();
                                SensorData sd = gson.fromJson(e.getBody(String.class), SensorData.class);
                                SenorDataDao.addData(sd);
                            } catch (JMSException ex) {
                                ex.printStackTrace();
                            }
                        }
                    });

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        };
        timer.scheduleAtFixedRate(task, 0, 5000);
    }
    
}

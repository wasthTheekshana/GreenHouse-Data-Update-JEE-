/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package app;

import com.google.gson.Gson;
import com.theekshana.model.SensorData;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.jms.Connection;
import javax.jms.JMSException;
import javax.jms.MessageProducer;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.Topic;
import javax.jms.TopicConnectionFactory;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author wasat
 */
@WebServlet(name = "sendInfo", urlPatterns = {"/info"})
public class sendInfo extends HttpServlet {

    @Resource(lookup = "GreenHouse-Queue")
    private QueueConnectionFactory connectionFactory;

    @Resource(mappedName = "GreenHouse_Destinaion")
    private Queue queue;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
//        (Temperature, Humidity, Moisture and Light)
        String temperature = request.getParameter("temperature");
        String humidity = request.getParameter("humidity");
        String moisture = request.getParameter("moisture");
        String light = request.getParameter("light");

        SensorData sensorData = new SensorData(temperature, humidity, moisture, light);
        Gson gson = new Gson();

        try {
            QueueConnection c = connectionFactory.createQueueConnection();
            QueueSession session = c.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
            MessageProducer messageProducer = session.createProducer(queue);
            TextMessage createTextMessage = session.createTextMessage();
            createTextMessage.setText(gson.toJson(sensorData));
            messageProducer.send(createTextMessage);
        } catch (JMSException e) {
            Logger.getLogger(sendInfo.class.getName()).log(Level.SEVERE, null, e);
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

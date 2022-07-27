/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.theekshana.servelt;

import com.google.gson.Gson;
import com.theekshana.dao.SenorDataDao;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author wasat
 */
@WebServlet(name = "DataRecevier", urlPatterns = {"/DataRecevier"})
public class DataRecevier extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Gson g = new Gson();
        response.getWriter().write(g.toJson(SenorDataDao.getSensorDataList()));
    }


}

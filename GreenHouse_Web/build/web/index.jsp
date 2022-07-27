<%-- 
    Document   : index
    Created on : Jul 20, 2022, 5:43:00 PM
    Author     : wasat
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>GreenHouse-DashBoard</title>
        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-gH2yIJqKdNHPEq0n4Mqa/HGKIhSkIHeL5AyhkYV8i59U5AR6csBvApHHNl/vI1Bx" crossorigin="anonymous">
        <!-- JavaScript Bundle with Popper -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-A3rJD856KowSb7dwlZdYEkO39Gagi7vIsF0jrRAoQmDKKtQBHUuLZ9AsSv4jD4Xa" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="newcss.css"/>
        <!--<link rel="stylesheet" href="newcss1.css"/>-->
        <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>-->
       
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center" style="padding-top:20px">
                <div class="col-md-auto">
                    <h1>Green House Data</h1>
                    <hr>
                </div>
            </div>
            <div class="row" style="margin-top: 50px">

                <div class="col-sm-3">
                    <div class="card border-primary mb-3" style="max-width: 18rem;">
                        <div class="card-header">Temperature</div>
                        <div class="card-body">
                            <span class="card-text" id="temp1" style="font-size: 25px;font-weight: bold">00</span><span>°C</span>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="card border-success mb-3" style="max-width: 18rem;">
                        <div class="card-header">Humidity</div>
                        <div class="card-body">
                            <span class="card-text" id="hum1" style="font-size: 25px;font-weight: bold">00</span>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="card border-danger mb-3" style="max-width: 18rem;">
                        <div class="card-header">Moisture</div>
                        <div class="card-body">
                            <span class="card-text" id="moi1" style="font-size: 25px;font-weight: bold">00</span>
                        </div>
                    </div>
                </div>
                <div class="col-sm-3">
                    <div class="card border-warning mb-3" style="max-width: 18rem;">
                        <div class="card-header">Light</div>
                        <div class="card-body">
                            <span class="card-text" id="lig1" style="font-size: 25px;font-weight: bold">00</span>
                        </div>
                    </div>
                </div>


            </div>

        </div>
        <br><br>
        <div class="container">

            <div class="row">
                <div class="col-sm-6">
                    <table class="rwd-table">
                        <thead>
                            <tr>
                                <th>Time</th>
                                <th>Temperature</th>
                                <th>Humidity</th>
                                <th>Moisture</th>
                                <th>Light</th>
                            </tr>
                        </thead>
                        <tbody  id="tableView">


                            <tr>
                                <td data-th="Supplier Code">

                                </td>
                                <td data-th="Supplier Name">

                                </td>
                                <td data-th="Invoice Number">

                                </td>
                                <td data-th="Invoice Date">

                                </td>
                                <td data-th="Due Date">

                                </td>

                            </tr>

                        </tbody>
                    </table>
                </div>
                <div class="col-sm-6">
                    <div style="height:400px;width:600px">
                        <canvas id="myChart" style="height:400px;width:600px"></canvas>

                    </div>

                </div>

            </div>

        </div>
        <div class="footer" style="margin-top: 140px">
            <div class="container">
                <hr>
                <div class="row no-gutters">
                    <div class="col-12 col-sm-6 col-md-9">
                        <p style="font-weight: 600;">
                            &copy; Smart Green House Dashboard - Live Update in Sri Lanka
                        </p>
                    </div>
                    <div class="col-6 col-md-3">
                        <span><i class="fab fa-dev "></i></span> Devaloped by
                        <span>
                            <a href="https://www.linkedin.com/in/theekshana-hariscandra-572ab520a/">
                                Theekshana Harischandra
                            </a>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <!--<script src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js"></script>-->
        <script src="utils.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js@3.8.0/dist/chart.min.js" integrity="sha256-cHVO4dqZfamRhWD7s4iXyaXWVK10odD+qp4xidFzqTI=" crossorigin="anonymous"></script>
    </body>
    <script>
        var tempvalue;
        var humvalue;
        var moivalue;
        var lightvalue;
        var f1 = function loadTable() {
            $.ajax({
                url: "DataRecevier",
                dataType: 'json',
                success: function (data) {
                    let val;
                    const temp = [];
                    const hum = [];
                    const moi = [];
                    const lig = [];
                    const time = [];

                    $.each(data, function (key, value) {
                        val += '<tr><td>' + value.timestamp + '</td>';
                        val += '<td>' + value.temperature + '</td>';
                        val += '<td>' + value.humidity + '</td>';
                        val += '<td>' + value.moisture + '</td>';
                        val += '<td>' + value.light + '</td></tr>';
                        temp.push(value.temperature);
                        hum.push(value.humidity);
                        moi.push(value.moisture);
                        lig.push(value.light);
                        time.push(value.timestamp);

                        tempvalue = value.temperature;
                        humvalue = value.humidity;
                        moivalue = value.moisture;
                        lightvalue = value.light;

                    });
                    $('#tableView').html(val);
                    ChartLoader(temp, hum, moi, lig, time);
                 
                    $('#temp1').text(tempvalue);
                    $('#hum1').text(humvalue);
                    $('#moi1').text(moivalue);
                    $('#lig1').text(lightvalue);
                }
            });
        };
        setInterval(f1, 5000);
        console.log(f1);
//        var s1 = setInterval(loadTable(), 5000);
//        console.log(s1);
  function ChartLoader(temp, hum, moi, lig, time) {
           var charts =  new Chart("myChart", {
                type: "line",
                data: {
                    labels: time,
                    datasets: [{
                            label: 'Moisture',
                            data: moi,
                            borderColor: "red",
                            fill: false
                        }, {
                            label: 'Humidity',
                            data: hum,
                            borderColor: "green",
                            fill: false
                        }, {
                            label: 'Temperature',
                            data: temp,
                            borderColor: "blue",
                            fill: false
                        }, {
                            label: 'Light',
                            data: lig,
                            borderColor: "brown",
                            fill: false
                        }
                    ]
                },


                options: {
                    responsive: true,
                    plugins: {
                        title: {
                            display: true,
                            text: (ctx) => 'Chart.js Line Chart - stacked=' + ctx.chart.options.scales.y.stacked
                        },
                        tooltip: {
                            mode: 'index'
                        },
                    },
                    interaction: {
                        mode: 'nearest',
                        axis: 'x',
                        intersect: false
                    },
                    scales: {
                        x: {
                            title: {
                                display: true,
                                text: 'Time'
                            }
                        },
                        y: {
                            stacked: true,
                            title: {
                                display: true,
                                text: 'Value'
                            }
                        }
                    }
                }
            }
        );
           
        }
//         setInterval(f2, 2000);
    </script>

</html>

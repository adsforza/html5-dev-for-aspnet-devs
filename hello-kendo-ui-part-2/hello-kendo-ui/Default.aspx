﻿<!DOCTYPE html>

<html>
<head>
    <title></title>
    <link href="Content/kendo/2012.2.710/kendo.common.min.css" rel="stylesheet" type="text/css" />
    <link href="Content/kendo/2012.2.710/kendo.default.min.css" rel="stylesheet" type="text/css" />
</head>
<body>

    <div id="employeesGrid"></div>
    <button class="k-button" id="updateButton">Save</button>

    <script src="Scripts/jquery-1.7.2.min.js"></script>
    <script src="Scripts/kendo/2012.2.710/kendo.web.min.js"></script>

    <script>

        $(function () {

            // select the employeesGrid empty div and call the 
            // kendoGrid function to transform it into a grid
            var grid = $("#employeesGrid").kendoGrid({
                // specify the columns on the grid
                columns: [
                        { field: "FirstName", title: "First Name" },
                        { field: "LastName", title: "Last Name" }
                ],
                editable: true,
                // the datasource for the grid
                dataSource: new kendo.data.DataSource({
                    // the transport tells the datasource what endpoints
                    // to use for CRUD actions
                    transport: {
                        read: "api/employees",
                        update: {
                            url: function (employee) {
                                return "api/employees/" + employee.Id
                            },
                            type: "POST"
                        }
                        //function (employee) {
                        //   return "api/employees/" + employee.Id
                        //},
                    },
                    // the schema defines the schema of the JSON coming
                    // back from the server so the datasource can parse it
                    schema: {
                        // the array of repeating data elements (employees)
                        data: "Data",
                        // the total count of records in the whole dataset. used
                        // for paging.
                        total: "Count",
                        model: {
                            id: "Id",
                            fields: {
                                FirstName: { editable: false },
                                LastName: { editable: true, nullable: false, validation: { required: true} }
                            }
                        }
                    },
                    // the number of records to show per page
                    pageSize: 3,
                    serverPaging: true
                }),
                pageable: true
            }).data("kendoGrid");

            $("#updateButton").on("click", function () {
                grid.dataSource.sync();
            });

        });

    
    </script>

</body>
</html>
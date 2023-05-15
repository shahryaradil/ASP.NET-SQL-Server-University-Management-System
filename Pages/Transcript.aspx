<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Transcript.aspx.cs" Inherits="DB_Project.Pages.Transcript" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="favicon.ico" type="image/x-icon">
    <title>Flex Academic Portal - Transcript</title>
    <style>
        body {
            background-color: rgba(200, 210, 200, 1.0);
            font-family: "Montserrat", sans-serif;
            color: #333;
            margin: 0;
            padding: 0px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .overlay {
            background-color: rgba(255, 255, 255, 0.6);
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: -1;
        }

        .flex-text {
            font-size: 42px;
            font-weight: bold;
            color: #44AC48;
            margin-left: 0px;
            text-align: center;
            text-shadow: 1.5px 1.5px #999;
            padding: 0px;
            padding-top: 20px;
            width: 400px;
        }

        h1 {
            color: #44AC48;
            text-align: center;
            font-size: 36px;
            margin: 0;
            text-shadow: 1px 1px #999;
        }

        .linkbar {
            background-color: rgba(250, 250, 250, 1.0);
            padding: 30px;
            width: 250px;
            border-radius: 10px;
            box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            position: fixed;
            left: 0;
            top: 0;
            bottom: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .linkbar {
            left: -250px;
            transition: left 0.5s ease-in-out;
        }

            .linkbar:hover,
            .linkbar:hover ~ .overlay,
            .link-btn:hover ~ .linkbar {
                left: 0;
            }

        .link-btn {
            cursor: pointer;
        }

        .linkbar a {
            display: block;
            margin: 10px;
            text-align: center;
            font-size: 18px;
            font-weight: bold;
            color: #44AC48;
            text-decoration: none;
            padding: 10px;
            width: 200px;
            border-radius: 5px;
            box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

            .linkbar a:hover {
                background-color: #44AC48;
                color: #FFF;
                box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.2), 0px 0px 10px rgba(0, 0, 0, 0.2);
                transform: translateY(-5px);
            }

        .profile {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 50px;
        }

        .section {
            background-color: rgba(250, 250, 250, 1.0);
            padding: 30px;
            width: 700px;
            border-radius: 10px;
            box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            position: relative;
            z-index: 1;
            margin: 20px;
            margin-left: 0px;
        }

            .section h2 {
                color: #44AC48;
                text-align: center;
                font-size: 24px;
                margin: 0;
                text-shadow: 1px 1px #999;
            }

            .section ul {
                list-style: none;
                margin: 0;
                padding: 0;
                text-align: left;
            }

        li {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

            li span {
                font-weight: bold;
            }

        .transcript {
            display: flex;
            flex-direction: column;
            align-items: center;
            margin-top: 50px;
        }

        .semester {
            margin-bottom: 20px;
            font-size: 18px;
            font-weight: bold;
            color: #44AC48;
            text-shadow: 1px 1px #999;
        }

        .table-container {
            width: 700px;
            margin: 0 auto;
            overflow-x: auto;
        }

            .table-container table {
                width: 100%;
                border-collapse: collapse;
                text-align: center;
            }

                .table-container table thead {
                    background-color: #44AC48;
                    color: #fff;
                }

                .table-container table th,
                .table-container table td {
                    padding: 10px;
                    border: 1px solid #ddd;
                }

                .table-container table td {
                    background-color: white;
                }

                    .table-container table td:first-child {
                        font-weight: bold;
                    }
    </style>
</head>
<body>
    <div class="overlay"></div>
    <h1 class="flex-text">Transcript</h1>
    <div class="linkbar">
        <a href="Home.aspx" class="link-btn">Home</a>
        <a href="CourseRegistration.aspx">Course Registration</a>
        <a href="Attendance.aspx">Attendance</a>
        <a href="Marks.aspx">Marks</a>
        <a href="Transcript.aspx">Transcript</a>
        <a href="Feedback.aspx">Feedback</a>
        <a href="LogIn.aspx">Logout</a>
    </div>
    <div class="transcript">
        <div class="section">
            <div class="semester">Student Transcript</div>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Course Code</th>
                            <th>Course Title</th>
                            <th>Units</th>
                            <th>Grade</th>
                            <th>Semester</th>
                        </tr>
                    </thead>
                    <tbody id="transcriptTableBody" runat="server"></tbody>
                </table>
            </div>
        </div>
        <div class="section">
            <h2>Current GPA</h2>
            <div class="gpa">
                <asp:Label class="semester" ID="labelGPA" runat="server" /></div>
        </div>
    </div>

</body>
</html>

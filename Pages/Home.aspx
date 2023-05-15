<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="DB_Project.Pages.Home" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="favicon.ico" type="image/x-icon">
    <title>Flex Academic Portal - Home</title>
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
                -webkit-transform: translateY(-2px);
                transform: translateY(-2px);
                -webkit-transform: translateY(-2px); 
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

            .section
            ul {
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

        .spanBold {
            font-weight: bold;
        }

        .gpa {
            margin-top: 20px;
            font-size: 18px;
            font-weight: bold;
            color: #44AC48;
            text-shadow: 1px 1px #999;
            text-underline-position: under;
        }
    </style>
</head>
<body>
    <div class="overlay"></div>
    <h1 class="flex-text">Home</h1>
    <div class="linkbar">
        <a href="Home.aspx" class="link-btn">Home</a>
        <a href="CourseRegistration.aspx">Course Registration</a>
        <a href="Attendance.aspx">Attendance</a>
        <a href="Marks.aspx">Marks</a>
        <a href="Transcript.aspx">Transcript</a>
        <a href="Feedback.aspx">Feedback</a>
        <a href="LogIn.aspx">Logout</a>
    </div>
    <div class="profile">
        <div class="section">
            <h2>University Information</h2>
            <ul>
                <li><span class="spanBold">University:</span> FAST University</li>
                <li><span class="spanBold">Program:</span><asp:Label ID="labelProgram" runat="server" /></li>
            </ul>
        </div>
        <div class="section">
            <h2>Personal Information</h2>
            <ul>
                <li><span class="spanBold">Name:</span><asp:Label ID="labelName" runat="server" /></li>
                <li><span class="spanBold">Roll Number:</span>
                    <asp:Label ID="labelRollNo" runat="server" /></li>
                <li><span class="spanBold">Date of Birth:</span><asp:Label ID="labelDOB" runat="server" /></li>
            </ul>
        </div>
        <div class="section">
            <h2>Contact Information</h2>
            <ul>
                <li><span class="spanBold">Email:</span><asp:Label ID="labelEmail" runat="server" /></li>
                <li><span class="spanBold">Phone:</span><asp:Label ID="labelPhone" runat="server" /></li>
                <li><span class="spanBold">Address:</span><asp:Label ID="labelAddress" runat="server" /></li>
            </ul>
        </div>
        <div class="section">
            <h2>Current GPA</h2>
            <div class="gpa">
                <asp:Label ID="labelGPA" runat="server" /></div>
        </div>
    </div>
</body>
</html>

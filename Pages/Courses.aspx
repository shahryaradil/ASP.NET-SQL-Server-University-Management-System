<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Courses.aspx.cs" Inherits="DB_Project.Pages.Courses" %>

<!DOCTYPE html>
<html>
<head>
    <title>Flex Academic Portal - Courses</title>
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
                box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.2), 0px 0px 10px rgba(0, 0, 0, 0)
            }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: center;
        }

        th,
        td {
            padding: 10px;
            border: 1px solid #ddd;
        }

        td {
            background-color: white;
        }

        th {
            background-color: #44AC48;
            color: white;
        }

        .semester-heading {
            margin-bottom: 20px;
            font-size: 18px;
            font-weight: bold;
            color: #44AC48;
            text-shadow: 1px 1px #999;
        }

        .semester-table {
            margin-top: 20px;
        }

            .semester-table td:first-child {
                font-weight: bold;
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
    </style>
</head>
<body>
    <div class="overlay"></div>
    <h1 class="flex-text">Courses</h1>
    <div class="linkbar">
        <a href="AdminHome.aspx" class="link-btn">Home</a>
        <a href="OfferCourses.aspx">Offer Courses</a>
        <a href="AllocateStudents.aspx">Allocate Students</a>
        <a href="AllocateFaculty.aspx">Allocate Faculty</a>
        <a href="Registration.aspx">Registration</a>
        <a href="Courses.aspx" class="link-btn">Courses</a>
        <a href="StudentsSections.aspx">Students Sections</a>
        <a href="CourseAllocation.aspx">Course Allocation</a>
        <a href="LogIn.aspx">Logout</a>
    </div>
    <div class="section">
        <div class="semester-heading">Fall 2022</div>
        <table class="semester-table">
            <thead>
                <tr>
                    <th>Course Codes</th>
                    <th>Courses</th>
                    <th>Credit Hours</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>CSCI 101</td>
                    <td>Introduction to Computer Science</td>
                    <td>3</td>
                </tr>
                <tr>
                    <td>CSCI 201</td>
                    <td>Data Structures and Algorithms</td>
                    <td>3</td>
                </tr>
                <tr>
                    <td>MATH 301</td>
                    <td>Linear Algebra</td>
                    <td>3</td>
                </tr>
            </tbody>
        </table>
    </div>
    <div class="section">
        <div class="semester-heading">Spring 2023</div>
        <table class="semester-table">
            <thead>
                <tr>
                    <th>Course Codes</th>
                    <th>Courses</th>
                    <th>Credit Hours</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>CSCI 202</td>
                    <td>Programming Fundamentals</td>
                    <td>3</td>
                </tr>
                <tr>
                    <td>CSCI 301</td>
                    <td>Operating Systems</td>
                    <td>3</td>
                </tr>
                <tr>
                    <td>MATH 302</td>
                    <td>Calculus II</td>
                    <td>3</td>
                </tr>
                <tr>
                    <td>CHEM 101</td>
                    <td>General Chemistry I</td>
                    <td>3</td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>

<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="DB_Project.Pages.Registration" %>

<!DOCTYPE html>
<html>
<head>
    <title>Registration Form</title>
    <style>
        body {
            background-color: rgba(200, 210, 200, 1.0);
            font-family: "Montserrat", sans-serif;
            color: #333;
            margin: 0;
            padding: 0px;
            height: 145vh;
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

        h1 {
            color: #44ac48;
            text-align: center;
            font-size: 36px;
            margin: 0;
            text-shadow: 1px 1px #999;
        }

        form {
            background-color: rgba(250, 250, 250, 1.0);
            padding: 50px;
            width: 500px;
            border-radius: 10px;
            box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            position: relative;
            z-index: 1;
        }

        label {
            color: #454545;
            display: block;
            font-size: 18px;
            font-weight: bold;
            letter-spacing: 2px;
            margin-top: 20px;
            text-transform: uppercase;
            text-align: left;
        }

        #username {
            margin-bottom: 0;
        }

        #signup {
            margin-top: 50px;
        }

        input {
            background-color: rgba(255, 255, 255, 1.0);
            border: none;
            border-radius: 7px;
            color: #333;
            font-family: "Montserrat", sans-serif;
            font-size: 16px;
            margin-bottom: 20px;
            margin-top: 20px;
            padding: 12px;
            width: 92.5%;
            box-shadow: 1px 1px #999;
        }

        select {
            background-color: rgba(255, 255, 255, 1.0);
            border: none;
            border-radius: 7px;
            color: #333;
            font-family: "Montserrat", sans-serif;
            font-size: 16px;
            margin-bottom: 5px;
            margin-top: 20px;
            padding: 12px;
            width: 98%;
            box-shadow: 1px 1px #999;
        }

        button {
            background-color: #44ac48;
            border: none;
            border-radius: 7px;
            box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2);
            color: #fff;
            cursor: pointer;
            font-family: "Montserrat", sans-serif;
            font-size: 18px;
            font-weight: bold;
            letter-spacing: 2px;
            margin-top: 5px;
            padding: 15px 30px;
            text-transform: uppercase;
            transition: all 0.3s ease;
            display: block;
            margin: 10px auto;
        }

            button:hover {
                background-color: #e5e5e5;
                color: #44ac48;
                box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.2), 0px 0px 10px rgba(0, 0, 0, 0.2);
                transform: translateY(-5px);
                -webkit-transform: translateY(-2px);
                transform: translateY(-2px);
                -webkit-transform: translateY(-2px);
            }

        hr {
            border: 0;
            height: 1px;
            background-color: #ccc;
            margin-top: 50px;
            margin-bottom: 50px;
            width: 80%;
        }

        .flex-text {
            font-size: 42px;
            font-weight: bold;
            color: #44ac48;
            margin: 50px;
            text-align: center;
            text-shadow: 1.5px 1.5px #999;
            padding: 20px;
            width: 400px;
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
            color: #44ac48;
            text-decoration: none;
            padding: 10px;
            width: 200px;
            border-radius: 5px;
            box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

            .linkbar a:hover {
                background-color: #44ac48;
                color: #fff;
                box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.2), 0px 0px 10px rgba(0, 0, 0, 0.2);
                transform: translateY(-5px);
                -webkit-transform: translateY(-2px);
                transform: translateY(-2px);
                -webkit-transform: translateY(-2px);
            }
    </style>
</head>
<body>
    <div class="overlay"></div>
    <h1 class="flex-text">Flex Academic Portal</h1>
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
    </head>
   
    <form>
        <input type="text" id="fullname" name="fullname" placeholder="Full Name" required />
        <input type="text" id="rollnumber" name="rollnumber" placeholder="Roll Number" required />
        <input type="email" id="email" name="email" placeholder="Email" required />
        <input type="password" id="password" name="password" placeholder="Password" required />
        <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm Password" required />

        <select id="department" name="department">
            <option value="" disabled selected>Select Department</option>
            <option value="Computer Science">Computer Science</option>
            <option value="Data Science">Data Science</option>
            <option value="Electrical Engineering">Electrical Engineering</option>
            <option value="Software Engineering">Software Engineering</option>
        </select>
        <button type="submit" id="signup">Register</button>
        <button type="submit" id="delete">Remove</button>
    </form>
    <hr>
</body>
</html>

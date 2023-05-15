<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Feedback.aspx.cs" Inherits="DB_Project.Pages.Feedback" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="favicon.ico" type="image/x-icon">
    <title>Flex Academic Portal - Teachers Assessment Form</title>
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
            height: 440vh;
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
            color: #44ac48;
            margin-left: 0px;
            text-align: center;
            text-shadow: 1.5px 1.5px #999;
            padding: 0px;
            padding-top: 20px;
            width: 400px;
        }

        h1 {
            color: #44ac48;
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
            }

        .form-container {
            margin-top: 50px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .form-group {
            background-color: rgba(250, 250, 250, 1.0);
            display: flex;
            flex-direction: column;
            width: 600px;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 5px 5px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            position: relative;
            z-index: 1;
            margin: 20px;
            margin-left: 0px;
        }

        label {
            font-weight: bold;
            margin-bottom: 10px;
        }

        .form-group input {
            background-color: rgba(255, 255, 255, 1.0);
            border: none;
            border-radius: 7px;
            color: #333;
            font-family: "Montserrat", sans-serif;
            font-size: 16px;
            margin-bottom: 20px;
            margin-top: 20px;
            margin-left: 10px;
            padding: 12px;
            width: 92.5%;
            box-shadow: 1px 1px #999;
        }

        .form-group select {
            background-color: rgba(255, 255, 255, 1.0);
            border: none;
            border-radius: 7px;
            color: #333;
            font-family: "Montserrat", sans-serif;
            font-size: 16px;
            margin-bottom: 20px;
            margin-top: 20px;
            margin-left: 22.5px;
            padding: 12px;
            width: 92.5%;
            box-shadow: 1px 1px #999;
        }


        .rating-container {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
        }

            .rating-container label {
                margin-right: 10px;
                width: 2000px;
            }

            .rating-container input[type="radio"] {
                transform: scale(1.25);
            }

        .comments-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            margin-top: 20px;
            width: 600px;
        }

            .comments-container label {
                margin-bottom: 10px;
            }

        textarea {
            font-size: 16px;
            height: 100px;
            resize: none;
            background-color: rgba(255, 255, 255, 1.0);
            border: none;
            border-radius: 7px;
            color: #333;
            font-family: "Montserrat", sans-serif;
            font-size: 16px;
            margin-bottom: 20px;
            margin-top: 20px;
            margin-left: 10px;
            padding: 12px;
            width: 92.5%;
            box-shadow: 1px 1px #999;
        }

        .submit-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 20px;
            width: 600px;
        }

        button {
            background-color: #44AC48;
            border: none;
            border-radius: 7px;
            box-shadow: 3px 3px 10px rgba(0, 0, 0, 0.2);
            color: #FFF;
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
            margin-left: 190px;
        }

            button:hover {
                background-color: #E5E5E5;
                color: #44AC48;
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
    <h1 class="flex-text">Teacher Assessment Form</h1>
    <div class="linkbar">
        <a href="Home.aspx" class="link-btn">Home</a>
        <a href="CourseRegistration.aspx">Course Registration</a>
        <a href="Attendance.aspx">Attendance</a>
        <a href="Marks.aspx">Marks</a>
        <a href="Transcript.aspx">Transcript</a>
        <a href="Feedback.aspx">Feedback</a>
        <a href="LogIn.aspx">Logout</a>
    </div>
    <div class="form-container">
        <form>
            <div class="form-group">
                <label for="date">Date:</label>
                <input type="date" id="date" name="date" required>
            </div>
            <div class="form-group">
                <label for="teacher-name">Name of Teacher:</label>
                <input type="text" id="teacher-name" name="teacher-name" required>
            </div>
            <div class="form-group">
                <label for="subject">Subject Code:</label>
                <input type="text" id="subject" name="subject" required>
            </div>
            <div class="form-group">
                <label>Please fill out the form in evaluating your instructor for the semester. After completion, please press the submit button.</label>

                <label>For reference, the metric are as follows:</label>

                <label>1  - Poor</label>
                <label>2 - Below Average</label>
                <label>3 - Average</label>
                <label>4 - Good</label>
                <label>5 - Excellent</label>

            </div>
            <div class="form-group">
                <h2>Appearance and Personal Presentation</h2>
                <div class="rating-container">
                    <label>Neatness:</label>
                    <input type="radio" name="appearance-neatness" value="5">
                    <input type="radio" name="appearance-neatness" value="4">
                    <input type="radio" name="appearance-neatness" value="3">
                    <input type="radio" name="appearance-neatness" value="2">
                    <input type="radio" name="appearance-neatness" value="1">
                </div>
                <div class="rating-container">
                    <label>Professional Attire:</label>
                    <input type="radio" name="appearance-attire" value="5">
                    <input type="radio" name="appearance-attire" value="4">
                    <input type="radio" name="appearance-attire" value="3">
                    <input type="radio" name="appearance-attire" value="2">
                    <input type="radio" name="appearance-attire" value="1">
                </div>
                <div class="rating-container">
                    <label>Punctuality:</label>
                    <input type="radio" name="appearance-punctuality" value="5">
                    <input type="radio" name="appearance-punctuality" value="4">
                    <input type="radio" name="appearance-punctuality" value="3">
                    <input type="radio" name="appearance-punctuality" value="2">
                    <input type="radio" name="appearance-punctuality" value="1">
                </div>
                <div class="rating-container">
                    <label>Communication Skills:</label>
                    <input type="radio" name="appearance-communication" value="5">
                    <input type="radio" name="appearance-communication" value="4">
                    <input type="radio" name="appearance-communication" value="3">
                    <input type="radio" name="appearance-communication" value="2">
                    <input type="radio" name="appearance-communication" value="1">
                </div>
                <div class="rating-container">
                    <label>Overall Impression:</label>
                    <input type="radio" name="appearance-impression" value="5">
                    <input type="radio" name="appearance-impression" value="4">
                    <input type="radio" name="appearance-impression" value="3">
                    <input type="radio" name="appearance-impression" value="2">
                    <input type="radio" name="appearance-impression" value="1">
                </div>
            </div>
            <div class="form-group">
                <h2>Professional Practices</h2>
                <div class="rating-container">
                    <label>Preparation and Organization:</label>
                    <input type="radio" name="practices-preparation" value="5">
                    <input type="radio" name="practices-preparation" value="4">
                    <input type="radio" name="practices-preparation" value="3">
                    <input type="radio" name="practices-preparation" value="2">
                    <input type="radio" name="practices-preparation" value="1">
                </div>
                <div class="rating-container">
                    <label>Use of Technology:</label>
                    <input type="radio" name="practices-technology" value="5">
                    <input type="radio" name="practices-technology" value="4">
                    <input type="radio" name="practices-technology" value="3">
                    <input type="radio" name="practices-technology" value="2">
                    <input type="radio" name="practices-technology" value="1">
                </div>
                <div class="rating-container">
                    <label>Availability:</label>
                    <input type="radio" name="practices-availability" value="5">
                    <input type="radio" name="practices-availability" value="4">
                    <input type="radio" name="practices-availability" value="3">
                    <input type="radio" name="practices-availability" value="2">
                    <input type="radio" name="practices-availability" value="1">
                </div>
                <div class="rating-container">
                    <label>Classroom Management:</label>
                    <input type="radio" name="practices-management" value="5">
                    <input type="radio" name="practices-management" value="4">
                    <input type="radio" name="practices-management" value="3">
                    <input type="radio" name="practices-management" value="2">
                    <input type="radio" name="practices-management" value="1">
                </div>
                <div class="rating-container">
                    <label>Responsiveness:</label>
                    <input type="radio" name="practices-responsiveness" value="5">
                    <input type="radio" name="practices-responsiveness" value="4">
                    <input type="radio" name="practices-responsiveness" value="3">
                    <input type="radio" name="practices-responsiveness" value="2">
                    <input type="radio" name="practices-responsiveness" value="1">
                </div>
            </div>
            <div class="form-group">
                <h2>Teaching Methods</h2>
                <div class="rating-container">
                    <label>Clarity and Explanation:</label>
                    <input type="radio" name="methods-clarity" value="5">
                    <input type="radio" name="methods-clarity" value="4">
                    <input type="radio" name="methods-clarity" value="3">
                    <input type="radio" name="methods-clarity" value="2">
                    <input type="radio" name="methods-clarity" value="1">
                </div>
                <div class="rating-container">
                    <label>Interaction and Engagement:</label>
                    <input type="radio" name="methods-interaction" value="5">
                    <input type="radio" name="methods-interaction" value="4">
                    <input type="radio" name="methods-interaction" value="3">
                    <input type="radio" name="methods-interaction" value="2">
                    <input type="radio" name="methods-interaction        " value="1">
                </div>
                <div class="rating-container">
                    <label>Relevance to Course Objectives:</label>
                    <input type="radio" name="methods-relevance" value="5">
                    <input type="radio" name="methods-relevance" value="4">
                    <input type="radio" name="methods-relevance" value="3">
                    <input type="radio" name="methods-relevance" value="2">
                    <input type="radio" name="methods-relevance" value="1">
                </div>
                <div class="rating-container">
                    <label>Assessment Methods:</label>
                    <input type="radio" name="methods-assessment" value="5">
                    <input type="radio" name="methods-assessment" value="4">
                    <input type="radio" name="methods-assessment" value="3">
                    <input type="radio" name="methods-assessment" value="2">
                    <input type="radio" name="methods-assessment" value="1">
                </div>
                <div class="rating-container">
                    <label>Feedback and Evaluation:</label>
                    <input type="radio" name="methods-feedback" value="5">
                    <input type="radio" name="methods-feedback" value="4">
                    <input type="radio" name="methods-feedback" value="3">
                    <input type="radio" name="methods-feedback" value="2">
                    <input type="radio" name="methods-feedback" value="1">
                </div>
            </div>
            <div class="form-group">
                <h2>Disposition Towards Students</h2>
                <div class="rating-container">
                    <label>Respect for Students:</label>
                    <input type="radio" name="disposition-respect" value="5">
                    <input type="radio" name="disposition-respect" value="4">
                    <input type="radio" name="disposition-respect" value="3">
                    <input type="radio" name="disposition-respect" value="2">
                    <input type="radio" name="disposition-respect" value="1">
                </div>
                <div class="rating-container">
                    <label>Approachability and Friendliness:</label>
                    <input type="radio" name="disposition-approachability" value="5">
                    <input type="radio" name="disposition-approachability" value="4">
                    <input type="radio" name="disposition-approachability" value="3">
                    <input type="radio" name="disposition-approachability" value="2">
                    <input type="radio" name="disposition-approachability" value="1">
                </div>
                <div class="rating-container">
                    <label>Openness to Discussion:</label>
                    <input type="radio" name="disposition-openness" value="5">
                    <input type="radio" name="disposition-openness" value="4">
                    <input type="radio" name="disposition-openness" value="3">
                    <input type="radio" name="disposition-openness" value="2">
                    <input type="radio" name="disposition-openness" value="1">
                </div>
                <div class="rating-container">
                    <label>Handling of Questions and Concerns:</label>
                    <input type="radio" name="disposition-handling" value="5">
                    <input type="radio" name="disposition-handling" value="4">
                    <input type="radio" name="disposition-handling" value="3">
                    <input type="radio" name="disposition-handling" value="2">
                    <input type="radio" name="disposition-handling" value="1">
                </div>
                <div class="rating-container">
                    <label>Punctuality and Availability:</label>
                    <input type="radio" name="disposition-punctuality" value="5">
                    <input type="radio" name="disposition-punctuality" value="4">
                    <input type="radio" name="disposition-punctuality" value="3">
                    <input type="radio" name="disposition-punctuality" value="2">
                    <input type="radio" name="disposition-punctuality" value="1">
                </div>
            </div>
            <div class="form-group">
                <label for="comments">Additional Comments:</label>
                <textarea id="comments" name="comments" rows="4" cols="50"></textarea>
            </div>
            <button type="submit" id="submitButton">Submit Assessment</button>
            <asp:Label ID="lblSuccessful" runat="server" Text=""></asp:Label>
        </form>
    </div>
</body>
</html>

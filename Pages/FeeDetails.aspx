<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FeeDetails.aspx.cs" Inherits="DB_Project.Pages.FeeDetails" %>

<!DOCTYPE html>
<html>
  <head>
    <title>Flex Academic Portal - Fee Details</title>
    <style>
      /* Main content */
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
    /* Set initial position to be outside of the visible area */
    left: -250px;
    transition: left 0.5s ease-in-out;
  }

  /* Change the position to be visible when the mouse hovers over the button or the linkBar */
  .linkbar:hover,
  .linkbar:hover ~ .overlay,
  .link-btn:hover ~ .linkbar {
    left: 0;
  }

  .link-btn {
    /* Add a new class to the home button to use as a trigger for the linkBar */
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
    /* added vendor prefix for compatibility */
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

  .fee-table {
    width: 700px;
    margin: 50px auto;
    border-collapse: collapse;
  }

  .fee-table th,
  .fee-table td {
    padding: 10px;
    text-align: center;
    border: 1px solid #333;
  }

  .fee-table th {
    background-color: #44AC48;
    color: #FFF;
  }

  .fee-table td.submitted {
    background-color: #44AC48;
    color: #FFF;
  }

  .fee-table td.not-submitted {
    background-color: #F00;
    color: #FFF;
  }
</style>
</head>
  <body>
    <div class="overlay"></div>
    <h1 class="flex-text">Fee Details</h1>
    <div class="linkbar">
      <a href="Home.aspx" class="link-btn">Home</a>
      <a href="CourseRegistration.aspx">Course Registration</a>
      <a href="Attendance.aspx">Attendance</a>
      <a href="Marks.aspx">Marks</a>
      <a href="Transcript.aspx">Transcript</a>
      <a href="FeeDetails.aspx">Fee Details</a>
      <a href="Feedback.aspx">Feedback</a>
    </div>
    <div class="profile">
      <div class="section">
        <h2>Fee Details</h2>
        <table class="fee-table">
          <tr>
            <th>Semester</th>
            <th>Fee Amount</th>
            <th>Submission Date</th>
            <th>Status</th>
          </tr>
          <tr>
            <td>Spring 2021</td>
            <td>$1000</td>
            <td>March 15, 2021</td>
            <td class="submitted">Submitted</td>
          </tr>
          <tr>
            <td>Fall 2021</td>
            <td>$1000</td>
            <td>September 15, 2021</td>
            <td class="submitted">Submitted</td>
          </tr>
          <tr>
            <td>Spring 2022</td>
            <td>$1000</td>
            <td>March 15, 2022</td>
            <td class="not-submitted">Not Submitted</td>
          </tr>
          <tr>
        <td>Fall 2022</td>
        <td>$1000</td>
        <td>-</td>
        <td>-</td>
      </tr>
      <tr>
        <td>Spring 2023</td>
        <td>$1000</td>
        <td>-</td>
        <td>-</td>
      </tr>
      <tr>
        <td>Fall 2023</td>
        <td>$1000</td>
        <td>-</td>
        <td>-</td>
      </tr>
    </table>
  </div>
</div>
</body>
</html>
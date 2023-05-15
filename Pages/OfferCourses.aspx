<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OfferCourses.aspx.cs" Inherits="Project_DB.Pages.OfferCourses" %>

<!DOCTYPE html>
<html>
  <head>
  <link rel="icon" href="favicon.ico" type="image/x-icon">
  <title>Flex Academic Portal - Course Registration</title>
    <style>
      /* Main content */
      body {
        background-color: rgba(200, 210, 200, 1.0);
        font-family: "Montserrat", sans-serif;
        color: #333;
        margin: 0;
        padding: 0px;
        height: 125vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
      }

            .overlay {
        background-color: rgba(255, 255, 255, 0.4);
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
    padding: 20px;
    width: 400px;
  }

      h1 {
        color: #44AC48;
        text-align: center;
        font-size: 36px;
        margin: 0;
        text-shadow: 1px 1px #999;
      }

      input {
            background-color: rgba(255, 255, 255, 1.0);
            border: none;
            border-radius: 7px;
            color: #333;
            font-family: "Montserrat", sans-serif;
            font-size: 16px;
            margin-bottom: 0px;
            margin-top: 20px;
            padding: 12px;
            width: 92.5%;
            box-shadow: 1px 1px #999;
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
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        margin-left: 0px;
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
    -webkit-transform: translateY(-2px); /* added*/
    transform: translateY(-2px);
    -webkit-transform: translateY(-2px); /* added vendor prefix for compatibility */
  }

      select {
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

      input[type="submit"] {
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
            margin-top: 10px;
            padding: 15px 30px;
            text-transform: uppercase;
            transition: all 0.3s ease;
            display: block;
            margin-left: 12.5px;
            width: 45%;
        }

        input[type="submit"]:hover {
            background-color: #E5E5E5;
            color: #44AC48;
            box-shadow: 2px 2px 3px rgba(0, 0, 0, 0.2), 0px 0px 10px rgba(0, 0, 0, 0, 0.2);
            transform: translateY(-5px);
            -webkit-transform: translateY(-2px);
            transform: translateY(-2px);
            -webkit-transform: translateY(-2px);
        }

  /* Cut off line */
  hr {
    border: 0;
    height: 1px;
    background-color: #ccc;
    margin-top: 50px;
    margin-bottom: 50px;
    width: 80%;
  }

  /* Error message */
  .error {
    color: red;
    font-weight: bold;
    margin-top: 50px;
    margin-left: 325px;
  }
</style>
</head>
  <body>
    <div class="overlay"></div>
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
    <div class="overlay"></div>
    <h1 class="flex-text">Course Registration</h1>
    <form runat="server">
      <label for="courseCode">Course Code:</label>
      <asp:TextBox ID="courseCode" runat="server"></asp:TextBox>
      <label for="courseName">Course Name:</label>
      <asp:TextBox ID="courseName" runat="server"></asp:TextBox>
      <label for="crdHrs">Credit Hrs:</label>
      <asp:TextBox ID="crdHrs" runat="server"></asp:TextBox>

      <label for="prereq">Pre-requisite:</label>
      <asp:DropDownList ID="prereqDropdown" runat="server" class="input"></asp:DropDownList>

      <label for="electiveAssigned">Elective/Assigned:</label>
      <asp:DropDownList ID="electiveAssigned" runat="server" class="input"></asp:DropDownList>
      
      <asp:Button ID="btnOfferCourse" runat="server" Text="Offer Course" />        
    </form>      
  </body>
</html>
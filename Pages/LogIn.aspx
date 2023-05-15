<%@ Page Language="C#" CodeFile="Login.aspx.cs" Inherits="DB_Project.Pages.LoginPage" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="icon" href="favicon.ico" type="image/x-icon">
    <title>Sign In</title>
    <style>
        body {
            background-color: rgba(200, 210, 200, 1.0);
            font-family: "Montserrat", sans-serif;
            color: #333;
            margin: 0;
            padding: 0px;
            height: 100vh;
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
            color: #44AC48;
            text-align: center;
            font-size: 36px;
            margin: 0;
            text-shadow: 1px 1px #999;
        }

        form {
            background-color: rgba(250, 250, 250, 1.0);
            padding: 50px;
            width: 300px;
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

        #signin {
            margin-top: 50px;
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

        select {
            background-color: rgba(255, 255, 255, 1.0);
            border: none;
            border-radius: 7px;
            color: #333;
            font-family: "Montserrat", sans-serif;
            font-size: 16px;
            text-align: center;
            margin-bottom: 20px;
            margin-top: 20px;
            padding: 12px;
            width: 100%;
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
            color: #44AC48;
            margin: 50px;
            text-align: center;
            text-shadow: 1.5px 1.5px #999;
            padding: 20px;
            width: 400px;
        }
    </style>
</head>

<body>
    <div class="overlay"></div>
    <h1 class="flex-text">Flex Academic Portal</h1>
    <form runat="server">
        <label for="username">Username:</label>
        <asp:TextBox ID="username" runat="server" CssClass="textbox"></asp:TextBox>
        <label for="password">Password:</label>
        <asp:TextBox ID="password" runat="server" CssClass="textbox" TextMode="Password"></asp:TextBox>
        <label for="userType">User Type:</label>
        <asp:DropDownList ID="userType" runat="server" class="input">
            <asp:ListItem Text="Student" Value="student"></asp:ListItem>
            <asp:ListItem Text="Faculty" Value="faculty"></asp:ListItem>
            <asp:ListItem Text="Admin" Value="admin"></asp:ListItem>
        </asp:DropDownList>
        <asp:Button class="button" ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
        <asp:Label ID="lblError" runat="server" Text=""></asp:Label>
    </form>
    <hr>
</body>
</html>

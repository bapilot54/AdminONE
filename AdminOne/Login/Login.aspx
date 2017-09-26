<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="AdminOne.Login" %>


<!DOCTYPE html>

<html>

<head runat="server">

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>AdminOne</title>

    <link href="/Assets/css/bootstrap.css" rel="stylesheet">
    <link href="/Assets/font-awesome/css/font-awesome.css" rel="stylesheet">

    <link href="/Assets/css/animate.css" rel="stylesheet">
    <link href="/Assets/css/style.css" rel="stylesheet">

    <!-- Mainly scripts -->
    <script src="/Assets/js/jquery-2.1.1.js"></script>
    <script src="/Assets/js/bootstrap.min.js"></script>
    <script src="/Assets/js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="/Assets/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

    <!-- Custom and plugin javascript -->
    <script src="/Assets/js/inspinia.js"></script>
    <script src="/Assets/js/plugins/pace/pace.min.js"></script>

</head>

<body class="gray-bg">

    <form id="main" runat="server">

        <div class="middle-box text-center loginscreen animated fadeInDown">
            <div>
                <div>
                    <h1 class="logo-name">A1</h1>
                </div>
                <h3>Welcome to AdminOne</h3>
                <p>
                    Designed for Zeiss ANZ to provide the Ultimate in Cloud Based Process Management
                </p>
                <p>Login to see it in action.</p>
                <div class="m-t">

                    <%-- Login Error Message --%>
                    <div class="alert alert-danger alert-bordered" role="alert" id="alert_loginerror" runat="server" visible="false">
                        <button type="button" class="close" data-dismiss="alert"><span>×</span><span class="sr-only">Close</span></button>
                        <strong>Oops..</strong><br />
                        Incorrect Email or Password, please try again!
                    </div>

                    <div class="form-group">
                        <dx:ASPxTextBox ID="tb_email" runat="server" Width="100%" NullText="Email Address">
                            <ValidationSettings CausesValidation="true" ValidationGroup="login" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                                <RequiredField IsRequired="true" ErrorText="Email Address is Required" />
                                <RegularExpression ErrorText="Invalid Email Address" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" />
                            </ValidationSettings>
                        </dx:ASPxTextBox>
                    </div>

                    <div class="form-group">
                        <dx:ASPxTextBox ID="tb_password" runat="server" Width="100%" NullText="Password" Password="true">
                            <ValidationSettings CausesValidation="true" ValidationGroup="login" Display="Dynamic" ErrorDisplayMode="ImageWithTooltip">
                                <RequiredField IsRequired="true" ErrorText="Password is Required" />
                            </ValidationSettings>
                        </dx:ASPxTextBox>
                    </div>

                    <div class="form-group">
                        <dx:ASPxCheckBox ID="cb_rememberMe" runat="server" Text="Remember Me"></dx:ASPxCheckBox>
                    </div>

                    <dx:ASPxButton ID="btn_login" runat="server" CssClass="btn btn-w-m btn-primary m-b" Width="100%" Text="Login" Native="true" CausesValidation="true" ValidationGroup="login" OnClick="btn_login_Click"></dx:ASPxButton>

                    <a href="#">Forgot password?</a>

                </div>
                <p class="m-t">Chris Mather &copy; 2017   </p>
            </div>
        </div>

    </form>

</body>

</html>

Imports DevExpress.Web

Public Class CreateEditUserAccounts
    Inherits System.Web.UI.Page

    ' Load
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            ' Load User Roles (New User)
            loadUserRolesNewUser()

        End If

    End Sub



    ' Load User Roles (New User)
    Private Sub loadUserRolesNewUser()

        Dim roleNames() As String = Roles.GetAllRoles()
        dl_newUserRoles.DataSource = roleNames
        dl_newUserRoles.DataBind()

    End Sub


    ' Save New User to Database
    Protected Sub btn_newSaveUser_Click(sender As Object, e As EventArgs) Handles btn_newSaveUser.Click

        ' Check if the User Exists already, if so then exit
        If Membership.GetUser(tb_newEmail.Text.Trim.ToLower) Is Nothing Then
            saveNewUserCode()
        End If

    End Sub


    ' Save New User Code
    Private Sub saveNewUserCode()

        Dim newPassword As String = DateTime.Now.ToString("ffffff")

        Dim newUser As MembershipUser = Membership.CreateUser(tb_newEmail.Text.Trim.ToLower, newPassword, tb_newEmail.Text.Trim.ToLower, Nothing, Nothing, True, Nothing)

        ' Get the UserID as a GUID in order to populate the Additional User Details Table
        Dim UserID As Guid = Nothing
        Using dtcontext As New DataClassesDataContext
            Dim userIDString = From a In dtcontext.aspnet_Users Where a.UserName = tb_newEmail.Text.Trim.ToLower
            UserID = userIDString.FirstOrDefault.UserId
        End Using

        ' Insert the Additional User Details into the Table
        Using dtcontext As New DataClassesDataContext
            Dim userDetails = New AdditionalUserDetail With {
        .UserID = UserID,
        .FirstName = tb_newFirstName.Text,
        .LastName = tb_newLastName.Text,
        .ContactNumber = tb_newNumber.Text,
        .ReportingDivision = combo_newReportingDivision.Text,
        .FullName = tb_newFirstName.Text & " " & tb_newLastName.Text
        }
            dtcontext.AdditionalUserDetails.InsertOnSubmit(userDetails)
            dtcontext.SubmitChanges()
        End Using

        ' Update the User roles
        For Each item As DataListItem In dl_newUserRoles.Items
            If item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then
                Dim chk As ASPxCheckBox = TryCast(item.FindControl("cb_Roles"), ASPxCheckBox)
                If chk.Checked = True Then
                    If Roles.IsUserInRole(tb_newEmail.Text, chk.Text) = False Then
                        Roles.AddUserToRole(tb_newEmail.Text, chk.Text)
                    End If
                ElseIf chk.Checked = False Then
                    If Roles.IsUserInRole(tb_newEmail.Text, chk.Text) = True Then
                        Roles.RemoveUserFromRole(tb_newEmail.Text, chk.Text)
                    End If
                End If
            End If
        Next

        combo_editUserSelect.DataBind()
        UpdatePanel2.Update()

        clearNewUserFields()

        ' Send the New User Email
        'sendEmail.sendNewUserEmail(tb_newEmail.Text.Trim.ToLower, newPassword)

    End Sub


    ' Existing User Save Chnages Button
    Protected Sub btn_editUserSave_Click(sender As Object, e As EventArgs)
        existingUserSaveChanges()
    End Sub


    ' Existing User Save Changes Code
    Sub existingUserSaveChanges()

        ' UserName (Email)
        Dim userName As String = ""

        ' Get the Username from the UserID
        Using dtcontext As New DataClassesDataContext
            Dim result = From a In dtcontext.aspnet_Users Where a.UserId = Guid.Parse(combo_editUserSelect.Value) Select a
            userName = result.FirstOrDefault.UserName
        End Using

        Using dtContext As New DataClassesDataContext
            Dim result = From a In dtContext.AdditionalUserDetails Where a.UserID = Guid.Parse(combo_editUserSelect.Value) Select a
            result.FirstOrDefault.FirstName = tb_editFirstName.Text
            result.FirstOrDefault.LastName = tb_editLastName.Text
            result.FirstOrDefault.FullName = tb_editFirstName.Text & " " & tb_editLastName.Text
            result.FirstOrDefault.ContactNumber = tb_editContactNumber.Text
            result.FirstOrDefault.ReportingDivision = combo_editReportDivision.Text
            dtContext.SubmitChanges()
        End Using

        ' Update the User roles
        For Each item As DataListItem In dl_editUserRoles.Items
            If item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then
                Dim chk As ASPxCheckBox = TryCast(item.FindControl("cb_roles"), ASPxCheckBox)
                If chk.Checked = True Then
                    If Roles.IsUserInRole(userName, chk.Text) = False Then
                        Roles.AddUserToRole(userName, chk.Text)
                    End If
                ElseIf chk.Checked = False Then
                    If Roles.IsUserInRole(userName, chk.Text) = True Then
                        Roles.RemoveUserFromRole(userName, chk.Text)
                    End If
                End If
            End If
        Next

    End Sub


    ' Existing User - Selected User
    Protected Sub combo_editUserSelect_SelectedIndexChanged(sender As Object, e As EventArgs)

        ' Bind the User Roles Available
        Dim roleNames() As String = Roles.GetAllRoles()
        dl_editUserRoles.DataSource = roleNames
        dl_editUserRoles.DataBind()

        ' UserName (Email)
        Dim userName As String = ""

        ' Get the Username from the UserID
        Using dtcontext As New DataClassesDataContext
            Dim result = From a In dtcontext.aspnet_Users Where a.UserId = Guid.Parse(combo_editUserSelect.Value) Select a
            userName = result.FirstOrDefault.UserName
        End Using

        ' Populate the Existing User Account Data
        Using dtcontext As New DataClassesDataContext
            Dim result = From a In dtcontext.AdditionalUserDetails Where a.UserID = Guid.Parse(combo_editUserSelect.Value) Select a
            If result.FirstOrDefault IsNot Nothing Then
                tb_editFirstName.Text = result.FirstOrDefault.FirstName
                tb_editLastName.Text = result.FirstOrDefault.LastName
                tb_editEmailAddress.Text = result.FirstOrDefault.aspnet_User.UserName
                tb_editContactNumber.Text = result.FirstOrDefault.ContactNumber
                combo_editReportDivision.Text = result.FirstOrDefault.ReportingDivision
            End If
        End Using

        ' Set the Active Status Button
        Dim u As MembershipUser
        u = Membership.GetUser(userName)
        If u.IsApproved = True Then
            btn_editSetUserInactive.Text = "Set User Inactive"
            btn_editSetUserInactive.CssClass = "btn btn-w-m btn-warning m-b m-t m-r pull-right"
        ElseIf u.IsApproved = False Then
            btn_editSetUserInactive.Text = "Set User Active"
            btn_editSetUserInactive.CssClass = "btn btn-w-m btn-success m-b m-t m-r pull-right"
        End If


        ' Check the Selected Users Roles
        Dim selectedUsersRoles() As String = Roles.GetRolesForUser(userName)

        For Each item As DataListItem In dl_editUserRoles.Items
            If item.ItemType = ListItemType.Item Or ListItemType.AlternatingItem Then
                Dim chk As ASPxCheckBox = TryCast(item.FindControl("cb_roles"), ASPxCheckBox)
                If Linq.Enumerable.Contains(Of String)(selectedUsersRoles, chk.Text) Then
                    chk.Checked = True
                Else
                    chk.Checked = False
                End If
            End If
        Next

    End Sub


    ' Delete User Account
    Protected Sub btn_confirmUserDelete_Click(sender As Object, e As EventArgs)

        If combo_editReportDivision.SelectedItem IsNot Nothing Then
            Membership.DeleteUser(tb_editEmailAddress.Text)
            combo_editUserSelect.DataBind()

            dl_editUserRoles.DataSource = Nothing
            dl_editUserRoles.DataBind()
            clearExistingUserFields()

        End If

    End Sub


    ' Set User Inactive / Active
    Protected Sub btn_editSetUserInactive_Click(sender As Object, e As EventArgs)

        Dim u As MembershipUser
        u = Membership.GetUser(combo_editUserSelect.Text)

        If btn_editSetUserInactive.Text = "Set User Inactive" Then
            u.IsApproved = False
            btn_editSetUserInactive.Text = "Set User Active"
            btn_editSetUserInactive.CssClass = "btn btn-w-m btn-success m-b m-t m-r pull-right"
            Membership.UpdateUser(u)
        Else
            u.IsApproved = True
            btn_editSetUserInactive.Text = "Set User Inactive"
            btn_editSetUserInactive.CssClass = "btn btn-w-m btn-warning m-b m-t m-r pull-right"
            Membership.UpdateUser(u)
        End If

    End Sub


    ' Clear the New User Fields
    Private Sub clearNewUserFields()

        tb_newFirstName.Text = ""
        tb_newLastName.Text = ""
        tb_newEmail.Text = ""
        tb_newNumber.Text = ""
        combo_newReportingDivision.Text = ""

        loadUserRolesNewUser()

    End Sub


    ' Clear Existing User Fields
    Private Sub clearExistingUserFields()

        combo_editUserSelect.SelectedIndex = -1
        tb_editFirstName.Text = ""
        tb_editLastName.Text = ""
        tb_editEmailAddress.Text = ""
        tb_editContactNumber.Text = ""
        combo_editReportDivision.SelectedIndex = -1

        loadUserRolesNewUser()

    End Sub
End Class
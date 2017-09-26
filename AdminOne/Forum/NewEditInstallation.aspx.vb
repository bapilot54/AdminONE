Public Class NewEditInstallation
    Inherits System.Web.UI.Page


    ' Load
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            ' Check if this is an update and reload existing data
            If Request.QueryString("IID") IsNot Nothing Then
                hidden_installationID.Value = Request.QueryString("IID").ToString
                loadInstallationDetails()
                loadInitialSurvey()
            Else
                newInstallationCode()
            End If

        End If

    End Sub


    ' Load Existing Installation Details
    Private Sub loadInstallationDetails()

        Using dtcontext As New DataClassesDataContext

            Dim result1 = From a In dtcontext.ForumInstallationDetails Where a.InstallationID = hidden_installationID.Value Select a

            lbl_topCreatedBy.InnerText = result1.FirstOrDefault.CreatedBy & " @ " & result1.FirstOrDefault.CreatedDateTime
            lbl_topEditedBy.InnerText = result1.FirstOrDefault.UpdatedBy & " @ " & result1.FirstOrDefault.UpdatedDateTime

            tb_vendorName.Text = result1.FirstOrDefault.VendorName
            tb_vendorAddress.Text = result1.FirstOrDefault.VendorAddress
            tb_vendorAddress2.Text = result1.FirstOrDefault.VendorAddressCont
            tb_vendorPostCode.Text = result1.FirstOrDefault.VendorPostCode
            combo_vendorState.Text = result1.FirstOrDefault.VendorState
            combo_vendorCountry.Text = result1.FirstOrDefault.VendorCountry

            tb_vendorContactName.Text = result1.FirstOrDefault.VendorContactName
            tb_vendorContactNumber.Text = result1.FirstOrDefault.VendorContactNumber
            tb_vendorContactEmail.Text = result1.FirstOrDefault.VendorContactEmail

            combo_ZNSalesPerson.Text = result1.FirstOrDefault.ZeissSalesPerson
            combo_ZNEngineer.Text = result1.FirstOrDefault.ZeissEngineer

        End Using

    End Sub


    ' Load Existing Initital Survey
    Private Sub loadInitialSurvey()

        Using dtcontext As New DataClassesDataContext

            Dim result1 = From a In dtcontext.ForumSiteSurveys Where a.InstallationID = hidden_installationID.Value Select a

            cb_archiveAndViewer.Checked = result1.FirstOrDefault.ArchiveAndViewer
            cb_glaucomaWorkplaceMain.Checked = result1.FirstOrDefault.GlaucomaWorkplaceMain
            cb_retinaWorkplaceMain.Checked = result1.FirstOrDefault.RetinaWorkplaceMain
            spin_forumViewers.Text = result1.FirstOrDefault.FORUMUserLicences
            spin_glaucomaWorkplaceUsers.Text = result1.FirstOrDefault.GlaucomaWorkplaceUserLicences
            spin_retinaWorkplaceUsers.Text = result1.FirstOrDefault.RetinaWorkplaceUserLicences
            spin_zeissDeviceConnections.Text = result1.FirstOrDefault.ZeissDeviceConnections
            spin_thirdPartyDeviceConnections.Text = result1.FirstOrDefault.ThirdPartyDeviceConnections
            cb_emrRequired.Checked = result1.FirstOrDefault.EMRRequired
            combo_EMRVendors.Text = result1.FirstOrDefault.EMRVendor
            cb_dataCleanseRequired.Checked = result1.FirstOrDefault.DataCleanseRequired
            tb_notesandRequests.Text = result1.FirstOrDefault.RequestsAndNotes

            ' Glaucoma Workplace Main
            If cb_glaucomaWorkplaceMain.Checked Then
                spin_glaucomaWorkplaceUsers.Visible = True
            End If

            ' Retina Workplace Main
            If cb_retinaWorkplaceMain.Checked Then
                spin_retinaWorkplaceUsers.Visible = True
            End If

            ' EMR Required
            If cb_emrRequired.Checked = True Then
                cb_dataCleanseRequired.Visible = True
                combo_EMRVendors.Visible = True
            End If

        End Using

    End Sub


    ' New Installation Code
    Private Sub newInstallationCode()
        ' Set the Heading Labels
        lbl_topCreatedBy.InnerText = User.Identity.Name & " @ " & DateTime.Now.ToString
        lbl_topEditedBy.InnerText = User.Identity.Name & " @ " & DateTime.Now.ToString
    End Sub


    ' Glaucoma Workplace Checked
    Protected Sub cb_glaucomaWorkplaceMain_CheckedChanged(sender As Object, e As EventArgs)
        If cb_glaucomaWorkplaceMain.Checked = True Then
            spin_glaucomaWorkplaceUsers.Visible = True
        Else
            spin_glaucomaWorkplaceUsers.Visible = False
        End If
    End Sub


    ' Retina Workplace Checked
    Protected Sub cb_retinaWorkplaceMain_CheckedChanged(sender As Object, e As EventArgs)
        If cb_retinaWorkplaceMain.Checked = True Then
            spin_retinaWorkplaceUsers.Visible = True
        Else
            spin_retinaWorkplaceUsers.Visible = False
        End If
    End Sub


    ' EMR Connection Required
    Protected Sub cb_emrRequired_CheckedChanged(sender As Object, e As EventArgs)
        If cb_emrRequired.Checked = True Then
            combo_EMRVendors.Visible = True
            cb_dataCleanseRequired.Visible = True
        Else
            combo_EMRVendors.Visible = False
            combo_EMRVendors.SelectedIndex = -1
            cb_dataCleanseRequired.Visible = False
            cb_dataCleanseRequired.Checked = False
        End If
    End Sub


    ' EMR Vendor Index Changed
    Protected Sub combo_EMRVendors_SelectedIndexChanged(sender As Object, e As EventArgs)
        If combo_EMRVendors.SelectedItem IsNot Nothing Then
            cb_dataCleanseRequired.Checked = True
        Else
            cb_dataCleanseRequired.Checked = False
        End If
    End Sub


    ' Generate Installation ID
    Private Sub generateInstallationID()

        Dim FirstName As String = ""
        Dim LastName As String = ""

        Dim FirstNameInitial As Char = ""
        Dim LastNameInitial As Char = ""

        'Get the First Initials from the Users First And Last Names
        Using dtcontext As New DataClassesDataContext
            Dim result1 = From a In dtcontext.AdditionalUserDetails Join u In dtcontext.aspnet_Users On a.UserID Equals u.UserId Where u.UserName = User.Identity.Name
            FirstName = result1.FirstOrDefault.a.FirstName
            LastName = result1.FirstOrDefault.a.LastName
        End Using

        FirstNameInitial = FirstName.Substring(0, 1)
        LastNameInitial = LastName.Substring(0, 1)

        hidden_installationID.Value = FirstNameInitial & LastNameInitial & "-" & DateTime.Now.ToString("ddMMyyHHmmss")

    End Sub


    ' Save / Update Button
    Protected Sub btn_saveChanges_Click(sender As Object, e As EventArgs)
        saveUpdateCode()
    End Sub


    ' Save Update Code
    Private Sub saveUpdateCode()

        Using dtContext As New DataClassesDataContext


            ' If true then the record will update instead of save new
            Dim isUpdate As Boolean = False

            ' Set isUpdate Value
            If hidden_installationID.Value.Length > 0 Then
                isUpdate = True
            Else
                isUpdate = False

                ' Generate the Installation ID
                generateInstallationID()

            End If


            ' ForumInstallationDetails Table
            If Not isUpdate Then

                ' Insert New Installation
                Dim installationInsert = New ForumInstallationDetail With {
            .ID = Guid.Parse(Guid.NewGuid.ToString),
            .InstallationID = hidden_installationID.Value,
            .CreatedBy = User.Identity.Name,
            .CreatedDateTime = DateTime.Now,
            .UpdatedBy = User.Identity.Name,
            .UpdatedDateTime = DateTime.Now,
            .VendorName = tb_vendorName.Text,
            .VendorAddress = tb_vendorAddress.Text,
            .VendorAddressCont = tb_vendorAddress2.Text,
            .VendorPostCode = tb_vendorPostCode.Text,
            .VendorState = combo_vendorState.Text,
            .VendorCountry = combo_vendorCountry.Text,
            .VendorContactName = tb_vendorContactName.Text,
            .VendorContactNumber = tb_vendorContactNumber.Text,
            .VendorContactEmail = tb_vendorContactEmail.Text,
            .ZeissSalesPerson = combo_ZNSalesPerson.Text,
            .ZeissEngineer = combo_ZNEngineer.Text
                }
                dtContext.ForumInstallationDetails.InsertOnSubmit(installationInsert)
                dtContext.SubmitChanges()

            ElseIf isUpdate Then

                ' Update Existing Installation
                Dim installationUpdate = From a In dtContext.ForumInstallationDetails Where a.InstallationID = hidden_installationID.Value Select a
                installationUpdate.FirstOrDefault.UpdatedBy = User.Identity.Name
                installationUpdate.FirstOrDefault.UpdatedDateTime = DateTime.Now
                installationUpdate.FirstOrDefault.UpdatedBy = User.Identity.Name
                installationUpdate.FirstOrDefault.UpdatedDateTime = DateTime.Now
                installationUpdate.FirstOrDefault.VendorName = tb_vendorName.Text
                installationUpdate.FirstOrDefault.VendorAddress = tb_vendorAddress.Text
                installationUpdate.FirstOrDefault.VendorAddressCont = tb_vendorAddress2.Text
                installationUpdate.FirstOrDefault.VendorPostCode = tb_vendorPostCode.Text
                installationUpdate.FirstOrDefault.VendorState = combo_vendorState.Text
                installationUpdate.FirstOrDefault.VendorCountry = combo_vendorCountry.Text
                installationUpdate.FirstOrDefault.VendorContactName = tb_vendorContactName.Text
                installationUpdate.FirstOrDefault.VendorContactNumber = tb_vendorContactNumber.Text
                installationUpdate.FirstOrDefault.VendorContactEmail = tb_vendorContactEmail.Text
                installationUpdate.FirstOrDefault.ZeissSalesPerson = combo_ZNSalesPerson.Text
                installationUpdate.FirstOrDefault.ZeissEngineer = combo_ZNEngineer.Text
                dtContext.SubmitChanges()

            End If


            ' ForumSiteSurvey Table
            If Not isUpdate Then

                ' Insert Initial Survey
                Dim surveyInsert = New ForumSiteSurvey With {
                    .ID = Guid.Parse(Guid.NewGuid.ToString),
                    .InstallationID = hidden_installationID.Value,
                    .CreatedBy = User.Identity.Name,
                    .CreatedDateTime = DateTime.Now,
                    .UpdatedBy = User.Identity.Name,
                    .UpdatedDateTime = DateTime.Now,
                    .ArchiveAndViewer = cb_archiveAndViewer.Checked,
                    .GlaucomaWorkplaceMain = cb_glaucomaWorkplaceMain.Checked,
                    .RetinaWorkplaceMain = cb_retinaWorkplaceMain.Checked,
                    .FORUMUserLicences = spin_forumViewers.Text,
                    .GlaucomaWorkplaceUserLicences = spin_glaucomaWorkplaceUsers.Text,
                    .RetinaWorkplaceUserLicences = spin_retinaWorkplaceUsers.Text,
                    .ZeissDeviceConnections = spin_zeissDeviceConnections.Text,
                    .ThirdPartyDeviceConnections = spin_thirdPartyDeviceConnections.Text,
                    .EMRRequired = cb_emrRequired.Checked,
                    .EMRVendor = combo_EMRVendors.Text,
                    .DataCleanseRequired = cb_dataCleanseRequired.Checked,
                    .RequestsAndNotes = tb_notesandRequests.Text
                    }
                dtContext.ForumSiteSurveys.InsertOnSubmit(surveyInsert)
                dtContext.SubmitChanges()

            ElseIf isUpdate Then

                ' Update Initial Survey
                Dim surveyUpdate = From a In dtContext.ForumSiteSurveys Where a.InstallationID = hidden_installationID.Value Select a
                surveyUpdate.FirstOrDefault.UpdatedBy = User.Identity.Name
                surveyUpdate.FirstOrDefault.UpdatedDateTime = DateTime.Now
                surveyUpdate.FirstOrDefault.ArchiveAndViewer = cb_archiveAndViewer.Checked
                surveyUpdate.FirstOrDefault.GlaucomaWorkplaceMain = cb_glaucomaWorkplaceMain.Checked
                surveyUpdate.FirstOrDefault.RetinaWorkplaceMain = cb_retinaWorkplaceMain.Checked
                surveyUpdate.FirstOrDefault.FORUMUserLicences = spin_forumViewers.Text
                surveyUpdate.FirstOrDefault.GlaucomaWorkplaceUserLicences = spin_glaucomaWorkplaceUsers.Text
                surveyUpdate.FirstOrDefault.RetinaWorkplaceUserLicences = spin_retinaWorkplaceUsers.Text
                surveyUpdate.FirstOrDefault.ZeissDeviceConnections = spin_zeissDeviceConnections.Text
                surveyUpdate.FirstOrDefault.ThirdPartyDeviceConnections = spin_thirdPartyDeviceConnections.Text
                surveyUpdate.FirstOrDefault.EMRRequired = cb_emrRequired.Checked
                surveyUpdate.FirstOrDefault.EMRVendor = combo_EMRVendors.Text
                surveyUpdate.FirstOrDefault.DataCleanseRequired = cb_dataCleanseRequired.Checked
                surveyUpdate.FirstOrDefault.RequestsAndNotes = tb_notesandRequests.Text
                dtContext.SubmitChanges()

            End If


            ' ForumStages Table
            If Not isUpdate Then

                ' Insert Forum Stage
                Dim stageInsert = New ForumStage With {
                    .ID = Guid.Parse(Guid.NewGuid.ToString),
                    .InstallationID = hidden_installationID.Value,
                    .StepNumber = 1,
                    .StepStatus = 1,
                    .StageDescription = "Vendor and Zeiss Nominations",
                    .MainButtonText = "Edit Details",
                    .UpdatedBy = User.Identity.Name,
                    .UpdatedDateTime = DateTime.Now,
                    .CompletedBy = User.Identity.Name,
                    .CompletedDateTime = DateTime.Now,
                    .Notes = "",
                    .AssignedTo = User.Identity.Name
                    }
                dtContext.ForumStages.InsertOnSubmit(stageInsert)
                dtContext.SubmitChanges()

                ' Insert the Next Stage as this one is complete
                Dim stageInsert2 = New ForumStage With {
                    .ID = Guid.Parse(Guid.NewGuid.ToString),
                    .InstallationID = hidden_installationID.Value,
                    .StepNumber = 2,
                    .StepStatus = 0,
                    .StageDescription = "Initial Quotation",
                    .MainButtonText = "View Initial Quotation",
                    .UpdatedBy = User.Identity.Name,
                    .UpdatedDateTime = DateTime.Now,
                    .CompletedBy = User.Identity.Name,
                    .CompletedDateTime = DateTime.Now,
                    .Notes = "",
                    .AssignedTo = User.Identity.Name
                }
                dtContext.ForumStages.InsertOnSubmit(stageInsert2)
                dtContext.SubmitChanges()

            ElseIf isUpdate Then

                ' Updated Forum Stage
                Dim stageUpdate = From a In dtContext.ForumStages Where (a.InstallationID = hidden_installationID.Value And a.StepNumber = 1) Select a
                stageUpdate.FirstOrDefault.UpdatedBy = User.Identity.Name
                stageUpdate.FirstOrDefault.UpdatedDateTime = DateTime.Now
                dtContext.SubmitChanges()

            End If


            ' Set Percentage Complete in ForumInstallationDetails Table
            Dim percentUpdate = From a In dtContext.ForumInstallationDetails Where a.InstallationID = hidden_installationID.Value Select a
            percentUpdate.FirstOrDefault.PercentageComplete = 5
            dtContext.SubmitChanges()


            ' Redirect to the Installation Select Screen
            Response.Redirect("/Forum/Installations.aspx")

        End Using

    End Sub


End Class
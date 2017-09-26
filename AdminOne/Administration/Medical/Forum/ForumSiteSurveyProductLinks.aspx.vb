Public Class ForumSiteSurveyProductLinks
    Inherits System.Web.UI.Page


    ' Load
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    ' Survey Element Index Changed
    Protected Sub combo_surveyElementDescription_SelectedIndexChanged(sender As Object, e As EventArgs)

        ' Check if the product has been matched already
        Using dtcontext As New DataClassesDataContext
            Dim result = From a In dtcontext.ForumSurveyProductAllocations Join b In dtcontext.Med_Products On a.ProductRowID Equals b.ID Where a.SiteSurveyDescription = combo_surveyElementDescription.Text
            If result.FirstOrDefault IsNot Nothing Then
                ' Found a match
                combo_surveyProduct.Text = result.FirstOrDefault.b.ProductDescription
                lbl_surveyElement.InnerText = combo_surveyElementDescription.Text
                lbl_forumProduct.InnerText = combo_surveyProduct.Text
            Else
                combo_surveyProduct.SelectedIndex = -1
                lbl_surveyElement.InnerText = combo_surveyElementDescription.Text
                lbl_forumProduct.InnerText = combo_surveyProduct.Text
            End If
        End Using

    End Sub


    ' Forum Product Index Changed
    Protected Sub combo_surveyProduct_SelectedIndexChanged(sender As Object, e As EventArgs)

        If combo_surveyProduct.Text.Length > 0 Then
            lbl_forumProduct.InnerText = combo_surveyProduct.Text
        Else
            lbl_forumProduct.InnerText = "Not Selected"
        End If

    End Sub


    ' Save Allocations
    Protected Sub btn_saveAllocations_Click(sender As Object, e As EventArgs)

        Using dtContext As New DataClassesDataContext
            Dim allocation As New ForumSurveyProductAllocation
            allocation.ID = Guid.Parse(Guid.NewGuid.ToString)
            allocation.SiteSurveyDescription = combo_surveyElementDescription.Text
            allocation.ProductRowID = Guid.Parse(combo_surveyProduct.Value)

            dtContext.ForumSurveyProductAllocations.InsertOnSubmit(allocation)
            dtContext.SubmitChanges()
        End Using

    End Sub

End Class
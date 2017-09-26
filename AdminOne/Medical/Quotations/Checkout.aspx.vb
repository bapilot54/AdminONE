Imports DevExpress.Web

Public Class Checkout
    Inherits System.Web.UI.Page


    ' Load
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub


    ' Select a Vendor Show
    Protected Sub btn_SelectVendor_Click(sender As Object, e As EventArgs)
        ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "hide", "$('#modal_selectVendorShow').modal('show');", True)
    End Sub


    Private Sub gv_selectVendor_DataBound(sender As Object, e As EventArgs) Handles gv_selectVendor.DataBound
        gv_selectVendor.DataSource = ds_vendors
    End Sub

    Private Sub Checkout_Init(sender As Object, e As EventArgs) Handles Me.Init
        gv_selectVendor.DataSource = ds_vendors
        gv_selectVendor.DataBind()
    End Sub

    Private Sub gv_selectVendor_AfterPerformCallback(sender As Object, e As ASPxGridViewAfterPerformCallbackEventArgs) Handles gv_selectVendor.AfterPerformCallback

        MsgBox(e.Args.ToString)

    End Sub










    '' Verified Vendor Selected
    'Protected Sub gv_vendors_ValueChanged(sender As Object, e As EventArgs)

    '    tb_vendorName.Text = gv_vendors.GridView.GetRowValues(gv_vendors.GridView.FocusedRowIndex, "VendorName")
    '    tb_vendorAddress.Text = gv_vendors.GridView.GetRowValues(gv_vendors.GridView.FocusedRowIndex, "Address")
    '    tb_vendorAddress2.Text = gv_vendors.GridView.GetRowValues(gv_vendors.GridView.FocusedRowIndex, "Address2")
    '    tb_vendorPostCode.Text = gv_vendors.GridView.GetRowValues(gv_vendors.GridView.FocusedRowIndex, "PostCode")
    '    combo_vendorState.Text = gv_vendors.GridView.GetRowValues(gv_vendors.GridView.FocusedRowIndex, "State")
    '    combo_vendorCountry.Text = gv_vendors.GridView.GetRowValues(gv_vendors.GridView.FocusedRowIndex, "Country")

    'End Sub


    '' Clear Vendor
    'Protected Sub btn_clearVendor_Click(sender As Object, e As EventArgs)

    '    tb_vendorName.Text = ""
    '    tb_vendorAddress.Text = ""
    '    tb_vendorAddress2.Text = ""
    '    tb_vendorPostCode.Text = ""
    '    combo_vendorState.Text = ""
    '    combo_vendorCountry.Text = ""

    '    gv_vendors.Text = ""

    'End Sub

    'Private Sub ASPxCallbackPanel1_Callback(sender As Object, e As CallbackEventArgsBase) Handles ASPxCallbackPanel1.Callback

    '    tb_vendorName.Text = gv_vendors.GridView.GetRowValues(gv_vendors.GridView.FocusedRowIndex, "VendorName")
    '    tb_vendorAddress.Text = gv_vendors.GridView.GetRowValues(gv_vendors.GridView.FocusedRowIndex, "Address")
    '    tb_vendorAddress2.Text = gv_vendors.GridView.GetRowValues(gv_vendors.GridView.FocusedRowIndex, "Address2")
    '    tb_vendorPostCode.Text = gv_vendors.GridView.GetRowValues(gv_vendors.GridView.FocusedRowIndex, "PostCode")
    '    combo_vendorState.Text = gv_vendors.GridView.GetRowValues(gv_vendors.GridView.FocusedRowIndex, "State")
    '    combo_vendorCountry.Text = gv_vendors.GridView.GetRowValues(gv_vendors.GridView.FocusedRowIndex, "Country")

    'End Sub
End Class
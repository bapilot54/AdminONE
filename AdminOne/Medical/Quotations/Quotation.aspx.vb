Imports DevExpress.Web

Partial Public Class Quotation
    Inherits System.Web.UI.Page


    ' Shopping Cart Footer Variables
    Public GSTCurrencyLabel As String
    Public TotalIncGSTString As String
    Public TotalExGSTString As String
    Public GSTValueString As String
    Public CartItemCount As String


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            ' Set the Currency to Default
            returnCurrency()

            ' Load Cart if available
            If System.Web.HttpContext.Current.Session("CartInstance") IsNot Nothing Then
                bindSessiontoDatatable()
            Else
                createNewCart()
                bindSessiontoDatatable()
            End If

        End If

    End Sub


    ' Select Currency Index Changed
    Protected Sub rb_currencySelect_SelectedIndexChanged(sender As Object, e As EventArgs)
        returnCurrency()
    End Sub


    ' Return the Currency Selected from the RadioGroup
    Function returnCurrency()

        If rb_currencySelect.SelectedItem.Value = "AUD" Then

            ' Hide the PriceNZD Column, show the PriceAUD Column
            gv_products.Columns("PriceNZD").Visible = False
            gv_products.Columns("PriceAUD").Visible = True

            Return "AUD"

        ElseIf rb_currencySelect.SelectedItem.Value = "NZD" Then

            ' Hide the PriceAUD Column, Show the PriceNZD Column
            gv_products.Columns("PriceAUD").Visible = False
            gv_products.Columns("PriceNZD").Visible = True

            Return "NZD"

        End If

    End Function



    Private Sub gv_products_CustomButtonCallback(sender As Object, e As ASPxGridViewCustomButtonCallbackEventArgs) Handles gv_products.CustomButtonCallback

        If e.ButtonID = "Add" Then

            ' Get Values from the GridRow
            Dim index As Integer = gv_products.FocusedRowIndex

            Dim ProductID As String = ""
            ProductID = (gv_products.GetRowValues(index, "ID")).ToString

            Dim ProductDescription As String = ""
            ProductDescription = (gv_products.GetRowValues(index, "ProductDescription")).ToString

            Dim PartNumber As String = ""
            PartNumber = (gv_products.GetRowValues(index, "PartNumber")).ToString

            ' Get the Price Value
            Dim Price As Decimal = 0
            Dim Currency As String = ""
            If returnCurrency() = "AUD" Then
                Price = (gv_products.GetRowValues(index, "PriceAUD"))
                Currency = "AUD"
            ElseIf returnCurrency() = "NZD" Then
                Price = (gv_products.GetRowValues(index, "PriceNZD"))
                Currency = "NZD"
            End If

            ' Check if the Shopping Cart Instance Exists, if not then create
            If Session("CartInstance") Is Nothing Then
                createNewCart()
            End If

            addToCart(ProductID, ProductDescription, Price, Currency, PartNumber)

        End If

    End Sub


    ' Create a New Cart Datatable and Session
    Private Sub createNewCart()

        Dim dt As New DataTable
        If dt.TableName.Contains("CartInstance") Then
            Exit Sub
        Else
            dt = New DataTable("CartInstance")
            dt.Columns.Add("ProductID", GetType(String))
            dt.Columns.Add("ProductDescription", GetType(String))
            dt.Columns.Add("PartNumber", GetType(String))
            dt.Columns.Add("Price", GetType(Decimal))
            dt.Columns.Add("Currency", GetType(String))
            dt.Columns.Add("Quantity", GetType(Decimal))
        End If
        System.Web.HttpContext.Current.Session("CartInstance") = dt

    End Sub


    ' Add a Product to the Cart
    Private Function addToCart(ByVal ProductID As String, ByVal ProductDescription As String, ByVal Price As Decimal, ByVal Currency As String, ByVal PartNumber As String)

        Dim dt As DataTable = System.Web.HttpContext.Current.Session("CartInstance")

        If dt.Rows.Count = 0 Then
            ' Add New Row
            Dim dr As DataRow = dt.NewRow
            dr("ProductID") = ProductID
            dr("ProductDescription") = ProductDescription
            dr("PartNumber") = PartNumber
            dr("Price") = Price
            dr("Currency") = Currency
            dr("Quantity") = 1
            dt.Rows.Add(dr)
            System.Web.HttpContext.Current.Session("CartInstance") = dt
        ElseIf dt.Rows.Count > 0 Then
            ' Row Count is greater than 1, iterate through and see if the prouct has been added already, if so don't add again but increase the Quantity by 1
            Dim rowfound_Success() As DataRow
            rowfound_Success = dt.Select("[ProductID] = '" & ProductID & "'")
            If rowfound_Success.Length > 0 Then

                For i As Integer = 0 To dt.Rows.Count - 1
                    If dt.Rows(i)("ProductID") = ProductID Then
                        dt.Rows(i)("Quantity") += 1
                    End If
                Next

            ElseIf rowfound_Success.Length = 0 Then
                ' Add New Row
                Dim dr As DataRow = dt.NewRow
                dr("ProductID") = ProductID
                dr("ProductDescription") = ProductDescription
                dr("PartNumber") = PartNumber
                dr("Price") = Price

                dr("Quantity") = 1
                dt.Rows.Add(dr)
            End If
            System.Web.HttpContext.Current.Session("CartInstance") = dt
        End If

        bindSessiontoDatatable()

    End Function


    ' Rebind the Shopping cart datatable
    Sub bindSessiontoDatatable()

        Dim dt As DataTable = System.Web.HttpContext.Current.Session("CartInstance")

        ' Set the Cart Item Count
        CartItemCount = dt.Rows.Count.ToString

        repeater_shoppingCart.DataSource = dt
        repeater_shoppingCart.DataBind()

    End Sub



    Private Sub repeater_shoppingCart_ItemCreated(sender As Object, e As RepeaterItemEventArgs) Handles repeater_shoppingCart.ItemCreated

        If e.Item.ItemType = ListItemType.Footer Then

            If returnCurrency() = "AUD" Then
                GSTCurrencyLabel = "GST 10%:"
            ElseIf returnCurrency() = "NZD" Then
                GSTCurrencyLabel = "GST 15%:"
            End If

            Dim dt As DataTable = System.Web.HttpContext.Current.Session("CartInstance")

            Dim totalExGST As Single = 0
            For i As Integer = 0 To dt.Rows.Count - 1
                If dt.Rows.Count > 0 Then
                    totalExGST += (dt.Rows(i)("Price") * dt.Rows(i)("Quantity"))
                End If
            Next
            TotalExGSTString = totalExGST.ToString("c2")


            Dim totalGST As Single = 0
            If returnCurrency() = "AUD" Then
                totalGST = totalExGST * 0.1
            ElseIf returnCurrency() = "NZD" Then
                totalGST = totalExGST * 0.15
            End If
            GSTValueString = totalGST.ToString("c2")

            Dim totalIncGST As Single = 0
            totalIncGST = totalExGST + totalGST
            TotalIncGSTString = totalIncGST.ToString("c2")

        End If

    End Sub


    ' Update Quantities Number Changed
    Protected Sub spinedit_Quantity_NumberChanged(sender As Object, e As EventArgs)
        updateQuantities()
    End Sub

    ' Update Quantities Button Clicked
    Protected Sub spinedit_Quantity_ButtonClick(source As Object, e As ButtonEditClickEventArgs)
        updateQuantities()
    End Sub

    ' Update Quantities from Spin Edit Control
    Private Sub updateQuantities()

        ' Update Quantities
        For Each item As RepeaterItem In repeater_shoppingCart.Items

            Dim SpinEdit As ASPxSpinEdit = item.FindControl("spinedit_Quantity")
            Dim btnDeleteArg As LinkButton = item.FindControl("btn_delete")

            Dim ProductID As String = btnDeleteArg.CommandArgument

            ' Keep the SideBar Shopping Cart open when a delete is carried out
            ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "open", "$('li.dropdown').addClass('open');", True)

            Dim dt As DataTable = System.Web.HttpContext.Current.Session("CartInstance")
            For i As Integer = 0 To dt.Rows.Count - 1
                If dt.Rows(i)("ProductID") = ProductID Then
                    dt.Rows(i)("Quantity") = SpinEdit.Text
                    System.Web.HttpContext.Current.Session("CartInstance") = dt
                End If
            Next

        Next

        bindSessiontoDatatable()

    End Sub


    ' Shopping Cart Repeater Commands
    Private Sub repeater_shoppingCart_ItemCommand(source As Object, e As RepeaterCommandEventArgs) Handles repeater_shoppingCart.ItemCommand

        If (e.Item.ItemType = ListItemType.Item) Or (e.Item.ItemType = ListItemType.AlternatingItem) Then

            ' Delete Item from the Shopping Cart
            If e.CommandName = "btn_delete" Then

                ' Keep the SideBar Shopping Cart open when a delete is carried out
                ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "open", "$('li.dropdown').addClass('open');", True)

                Dim dt As DataTable = System.Web.HttpContext.Current.Session("CartInstance")
                Dim foundRow As DataRow() = dt.Select("[ProductID] = '" & e.CommandArgument & "'")
                If foundRow.Count > 0 Then
                    foundRow(0).Delete()
                End If

            End If

        End If

        bindSessiontoDatatable()

    End Sub


    ' Show confirm New Quotation Modal
    Protected Sub btn_newQuotation_Click(sender As Object, e As EventArgs)

        ScriptManager.RegisterStartupScript(UpdatePanel1, UpdatePanel1.GetType(), "hide", "$('#modal_newConfirm').modal('show');", True)

    End Sub


    ' New Quotation Code
    Protected Sub btn_confirmNew_Click(sender As Object, e As EventArgs)

        If Session("CartInstance") IsNot Nothing Then
            Session.Remove("CartInstance")
        End If

        ' Clear the GridView Filters
        gv_products.ClearSort()
        gv_products.FilterExpression = String.Empty
        gv_products.SearchPanelFilter = String.Empty

        createNewCart()

        bindSessiontoDatatable()

    End Sub


    ' Save Quotation
    Protected Sub btn_saveQuotation_Click(sender As Object, e As EventArgs)

        Dim dt As DataTable = System.Web.HttpContext.Current.Session("CartInstance")
        If dt.Rows.Count = 0 Then
            Toastr.ShowToast_UpdatePanel(Me, Toastr.ToastType.Warning, "Please add a Product before Saving", "Oops!", Toastr.ToastPosition.TopRight)
            Exit Sub
        End If

        Using dtContext As New DataClassesDataContext

            ' If true then the record will update instead of save new
            Dim isUpdate As Boolean = False

            ' Set isUpdate Value
            If hidden_QuotationID.Value.Length > 0 Then
                isUpdate = True
            Else
                isUpdate = False

                ' Generate the Installation ID
                generateQuotationID()
            End If

            ' Set the Currency
            Dim currency As String = returnCurrency()

            ' Med_QuotationDetails Table
            If Not isUpdate Then

                ' Insert New Quotation
                Dim QuotationInsert = New Med_QuotationDetail With {
            .ID = Guid.Parse(Guid.NewGuid.ToString),
            .QuotationID = hidden_QuotationID.Value,
            .CreatedBy = User.Identity.Name,
            .CreatedDateTime = DateTime.Now,
            .UpdatedBy = User.Identity.Name,
            .UpdatedDateTime = DateTime.Now,
            .ZeissSalesPerson = User.Identity.Name,
            .Currency = currency
                }
                dtContext.Med_QuotationDetails.InsertOnSubmit(QuotationInsert)
                dtContext.SubmitChanges()

            ElseIf isUpdate Then

                ' Update Existing Quotation
                Dim QuotationUpdate = From a In dtContext.Med_QuotationDetails Where a.QuotationID = hidden_QuotationID.Value Select a
                QuotationUpdate.FirstOrDefault.UpdatedBy = User.Identity.Name
                QuotationUpdate.FirstOrDefault.UpdatedDateTime = DateTime.Now
                QuotationUpdate.FirstOrDefault.Currency = currency
                dtContext.SubmitChanges()

            End If

            ' Get the ID of the Med_QuotationDetail Table
            Dim detailID = From a In dtContext.Med_QuotationDetails Where a.QuotationID = hidden_QuotationID.Value Select a
            Dim detailIDString As String = Convert.ToString(detailID.FirstOrDefault.ID)

            ' Med_QuotationProducts Table
            If Not isUpdate Then

                ' Get the Products from the Session
                For Each row In dt.Rows

                    Dim ProductID As String = row("ProductID").ToString
                    Dim addProductMatch = From a In dtContext.Med_Products Where a.ID = Guid.Parse(ProductID) Select a

                    Dim productsInsert = New Med_QuotationProduct With {
                        .ID = Guid.Parse(Guid.NewGuid.ToString),
                        .QuotationDetailsRowID = Guid.Parse(detailIDString),
                        .QuotationID = hidden_QuotationID.Value,
                        .ProductDescription = addProductMatch.FirstOrDefault.ProductDescription,
                        .ProductSubDescription = addProductMatch.FirstOrDefault.ProductSubDescription,
                        .PartNumber = addProductMatch.FirstOrDefault.PartNumber,
                        .ProductGroup = addProductMatch.FirstOrDefault.ProductGroup,
                        .PriceAUD = addProductMatch.FirstOrDefault.PriceAUD,
                        .PriceNZD = addProductMatch.FirstOrDefault.PriceNZD
                    }
                    dtContext.Med_QuotationProducts.InsertOnSubmit(productsInsert)
                    dtContext.SubmitChanges()

                Next

            ElseIf isUpdate Then

                ' Delete All Products from the Quotation
                Dim deleteProducts = From a In dtContext.Med_QuotationProducts Where a.QuotationID = hidden_QuotationID.Value Select a
                For Each product As Med_QuotationProduct In deleteProducts
                    dtContext.Med_QuotationProducts.DeleteOnSubmit(product)
                Next
                dtContext.SubmitChanges()

                ' Insert the Updated Products
                For Each row In dt.Rows

                    Dim ProductID As String = row("ProductID").ToString
                    Dim addProductMatch = From a In dtContext.Med_Products Where a.ID = Guid.Parse(ProductID) Select a

                    Dim productsInsert = New Med_QuotationProduct With {
                        .ID = Guid.Parse(Guid.NewGuid.ToString),
                        .QuotationDetailsRowID = Guid.Parse(detailIDString),
                             .QuotationID = hidden_QuotationID.Value,
                        .ProductDescription = addProductMatch.FirstOrDefault.ProductDescription,
                        .ProductSubDescription = addProductMatch.FirstOrDefault.ProductSubDescription,
                        .PartNumber = addProductMatch.FirstOrDefault.PartNumber,
                        .ProductGroup = addProductMatch.FirstOrDefault.ProductGroup,
                        .PriceAUD = addProductMatch.FirstOrDefault.PriceAUD,
                        .PriceNZD = addProductMatch.FirstOrDefault.PriceNZD
                    }
                    dtContext.Med_QuotationProducts.InsertOnSubmit(productsInsert)
                    dtContext.SubmitChanges()

                Next

            End If

            If isUpdate = False Then
                Toastr.ShowToast_UpdatePanel(Me, Toastr.ToastType.Success, hidden_QuotationID.Value & " Saved Successfully", "Success", Toastr.ToastPosition.TopRight)
            ElseIf isUpdate = True Then
                Toastr.ShowToast_UpdatePanel(Me, Toastr.ToastType.Success, hidden_QuotationID.Value & " Updated Successfully", "Success", Toastr.ToastPosition.TopRight)
            End If

        End Using

    End Sub


    ' Generate Quotation ID
    Private Sub generateQuotationID()

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

        hidden_QuotationID.Value = FirstNameInitial & LastNameInitial & "-" & DateTime.Now.ToString("ddMMyyHHmmss")

    End Sub

End Class
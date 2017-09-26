<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/AdminOne.Master" CodeBehind="Quotation.aspx.vb" Inherits="AdminOne.Quotation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <%-- Shopping Cart Window Control --%>
    <script>
        function pageLoad() {
            // Open Shopping Cart
            $('li.dropdown a').on('click', function (event) {
                $(this).parent().toggleClass('open');
            });
            // Close Shopping Cart when clicked outside the window
            $('body').on('click', function (e) {
                if (!$('li.dropdown').is(e.target)
                    && $('li.dropdown').has(e.target).length === 0
                    && $('.open').has(e.target).length === 0
                ) {
                    $('li.dropdown').removeClass('open');
                }
            });
        };
    </script>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="BreadrumbActionArea" runat="server">

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

            <asp:Repeater ID="repeater_shoppingCart" runat="server">

                <HeaderTemplate>
                    <ul class="nav navbar-top-links navbar-right">
                        <li class="dropdown">
                            <a class="dropdown-toggle count-info" href="#" aria-expanded="true">
                                <i class="fa fa-shopping-cart" style="font-size: 30px !important"></i><span class="label label-warning"><%# CartItemCount %></span>
                            </a>
                            <ul class="dropdown-menu dropdown-messages" style="width: 650px">
                                <li>
                                    <div class="text-center link-block m-b">
                                        <a href="mailbox.html">
                                            <strong>Medical Division Shopping Cart</strong>
                                        </a>
                                    </div>
                                </li>
                                <div class="row">
                                    <div class="col-sm-12" style="padding-left: 0px !important">
                                        <div class="col-sm-5">
                                            Description
                                        </div>
                                        <div class="col-sm-2">
                                            Unit Price
                                        </div>
                                        <div class="col-sm-2">
                                            Quantity
                                        </div>
                                        <div class="col-sm-2">
                                            SubTotal
                                        </div>
                                    </div>
                                </div>
                                <li class="divider"></li>
                </HeaderTemplate>

                <ItemTemplate>
                    <li>
                        <div class="dropdown-messages-box">
                            <div class="media-body">
                                <div class="row">
                                    <div class="col-sm-12" style="padding-left: 0px !important">
                                        <div class="col-sm-5">
                                            <strong><%# Eval("ProductDescription") %></strong><br />
                                            <small style="font-size: 11px"><%# Eval("PartNumber") %></><br />
                                        </div>
                                        <div class="col-sm-2">
                                            <strong><%# Eval("Price", "{0:c2}") %></strong>
                                        </div>
                                        <div class="col-sm-2">
                                            <dx:ASPxSpinEdit ID="spinedit_Quantity" runat="server" ClientIDMode="AutoID" Number='<%# Eval("Quantity") %>' Width="100%" MinValue="1" MaxValue="1000" Theme="MetropolisBlue" AutoPostBack="true" OnNumberChanged="spinedit_Quantity_NumberChanged" OnButtonClick="spinedit_Quantity_ButtonClick">
                                            </dx:ASPxSpinEdit>
                                        </div>
                                        <div class="col-sm-2">
                                            <strong><%# String.Format("{0:c2}", Eval("Price") * Eval("Quantity")) %></strong>
                                        </div>
                                        <div class="col-xs-1">
                                            <asp:LinkButton ID="btn_delete" runat="server" ClientIDMode="AutoID" CommandArgument='<%# Eval("ProductID") %>' CommandName="btn_delete"><i class="fa fa-times"></i></asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="divider"></li>
                </ItemTemplate>

                <FooterTemplate>
                    <div class="row m-t m-b">
                        <div class="col-sm-3 text-right" style="line-height: 0.5">
                            <h5>Total Ex GST:</h5>
                            <br />
                            <h5><%= GSTCurrencyLabel %></h5>
                            <br />
                            <h5>Total Inc GST:</h5>
                            <br />
                        </div>
                        <div class="col-sm-3 text-left" style="line-height: 0.5">
                            <h5><%= TotalExGSTString %></h5>
                            <br />
                            <h5><%= GSTValueString %></h5>
                            <br />
                            <h5><%= TotalIncGSTString %></h5>
                            <br />
                        </div>
                    </div>
                    <li class="divider"></li>
                    <li>
                        <div class="text-center link-block">
                            <a href="/Medical/Quotations/Checkout.aspx">
                                <i class="fa fa-hand-o-right"></i><strong>&nbsp; &nbsp;Checkout</strong>
                            </a>
                        </div>
                    </li>
                    </ul>
                </li>
            </ul>
                </FooterTemplate>

            </asp:Repeater>

        </ContentTemplate>
    </asp:UpdatePanel>

</asp:Content>


<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">

    <div class="ibox">
        <div class="ibox-title">
            <h5>Medical Division Quotation</h5>
            <div class="ibox-tools">
                <a class="collapse-link">
                    <i class="fa fa-chevron-up"></i>
                </a>
            </div>
        </div>
        <div class="ibox-content" style="display: block;">
            <div class="row">
                <div class="col-sm-12">

                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>

                            <asp:HiddenField ID="hidden_QuotationID" runat="server" />

                            <%-- Currency and Options --%>
                            <div class="row">
                                <div class="col-sm-3">
                                    <dx:ASPxRadioButtonList ID="rb_currencySelect" runat="server" ValueType="System.String" RepeatDirection="Horizontal" Native="false" Border-BorderStyle="None" AutoPostBack="true" OnSelectedIndexChanged="rb_currencySelect_SelectedIndexChanged">
                                        <Items>
                                            <dx:ListEditItem Text="AUD" Value="AUD" Selected="true" />
                                            <dx:ListEditItem Text="NZD" Value="NZD" />
                                        </Items>
                                    </dx:ASPxRadioButtonList>
                                </div>
                                <div class="col-sm-9">
                                    <dx:ASPxButton ID="btn_newQuotation" runat="server" CssClass='pull-right' Text="Create a New Quotation" Native="false" AutoPostBack="true" CausesValidation="false" OnClick="btn_newQuotation_Click"></dx:ASPxButton>
                                    <dx:ASPxButton ID="btn_saveQuotation" runat="server" CssClass='pull-right m-r' Text="Save Quotation" Native="false" AutoPostBack="true" CausesValidation="false" OnClick="btn_saveQuotation_Click"></dx:ASPxButton>
                                </div>
                            </div>

                            <dx:ASPxGridView ID="gv_products" runat="server" AutoGenerateColumns="False" DataSourceID="ds_products" KeyFieldName="ID" Width="100%" EnableCallBacks="false">
                                <SettingsAdaptivity AdaptivityMode="HideDataCells"></SettingsAdaptivity>
                                <Settings ShowFilterRow="True" ShowGroupPanel="True"></Settings>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True"></SettingsBehavior>

                                <SettingsDataSecurity AllowEdit="False" AllowInsert="False" AllowDelete="False"></SettingsDataSecurity>
                                <SettingsSearchPanel Visible="True"></SettingsSearchPanel>
                                <Columns>
                                    <dx:GridViewCommandColumn VisibleIndex="0" ShowClearFilterButton="True" ButtonRenderMode="Image" Caption="Add" ButtonType="Image" Width="50px">
                                        <CustomButtons>
                                            <dx:GridViewCommandColumnCustomButton ID="Add" Text="Add to Cart">
                                                <Image IconID="actions_buy_16x16devav"></Image>
                                            </dx:GridViewCommandColumnCustomButton>
                                        </CustomButtons>
                                    </dx:GridViewCommandColumn>
                                    <dx:GridViewDataTextColumn FieldName="ID" ReadOnly="True" VisibleIndex="1" Visible="False"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ProductDescription" VisibleIndex="2"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ProductSubDescription" VisibleIndex="3" Visible="False"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="PartNumber" VisibleIndex="4"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="ProductGroup" VisibleIndex="5"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="PriceAUD" VisibleIndex="6">
                                        <PropertiesTextEdit DisplayFormatString="c2"></PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="PriceNZD" VisibleIndex="7">
                                        <PropertiesTextEdit DisplayFormatString="c2"></PropertiesTextEdit>
                                    </dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="InternalNotes" VisibleIndex="8"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataTextColumn FieldName="VendorViewableNotes" VisibleIndex="9" Visible="False"></dx:GridViewDataTextColumn>
                                    <dx:GridViewDataCheckColumn FieldName="Active" VisibleIndex="10" Visible="False"></dx:GridViewDataCheckColumn>
                                    <dx:GridViewDataCheckColumn FieldName="PackageItemOnly" VisibleIndex="11" Visible="False"></dx:GridViewDataCheckColumn>
                                </Columns>
                            </dx:ASPxGridView>

                            <asp:SqlDataSource runat="server" ID="ds_products" ConnectionString='<%$ ConnectionStrings:DB8874_adminoneConnectionString %>' SelectCommand="SELECT * FROM [Med_Products] ORDER BY [ProductDescription]"></asp:SqlDataSource>

                            <%-- Modal New Quotation --%>
                            <div class="modal inmodal fade" id="modal_newConfirm" tabindex="-1" role="dialog" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                            <h4 class="modal-title">Confirm New Quotation</h4>
                                        </div>
                                        <div class="modal-body">
                                            <p>
                                                <strong>This operation cannot be reversed</strong><br />
                                                Please confirm that you wish to start a new Quotation?
                                            </p>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
                                            <dx:ASPxButton ID="btn_confirmNew" runat="server" CssClass="btn btn-danger" Text="New" Native="true" AutoPostBack="true" UseSubmitBehavior="false" data-dismiss="modal" OnClick="btn_confirmNew_Click"></dx:ASPxButton>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </ContentTemplate>
                    </asp:UpdatePanel>

                </div>
            </div>
        </div>
    </div>

</asp:Content>

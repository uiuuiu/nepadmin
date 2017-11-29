export var ProductDetail = { run: function() {
  var submitBtn;
  $('.datepicker').datepicker({
    todayHighlight: true,
    format: "dd/mm/yyyy"
  });

  $(document).on("click", "#btn_create_product_detail", function(){
    submitBtn = $(this)
  });

  $(document).on("submit", "form", function(){
    if(submitBtn.text() == "Create") {
      $(this).attr("action", "/admin/product_detail");
      $(this).find("input[name='_method']").remove();
    };
  });
}}
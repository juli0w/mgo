$(document).ready(function() {
  $(".btn-preview").click(function() {
    $("#preview-content").html("Carregando...");
    $("#preview-content").attr('src', $(this).attr('link'));
    $("#preview-modal").modal("open");
  });
});

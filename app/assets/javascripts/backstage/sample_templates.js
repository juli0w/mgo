$(document).ready(function() {
  $("#sample_template_select").change(function() {
    id = $(this).val();
    if (id == '') { return false; }

    $.get('/backstage/sample_templates/'+id).always(function(data) {

      fields = ['primary_color', 'detail_color', 'link_color', 'text_color', 'logo_color', 'description_color'];

      primary = data.primary_color;
      detail = data.detail_color;
      link = data.link_color;
      text = data.text_color;
      logo = data.logo_color;
      description = data.description_color;

      $("#hf_primary_color").val(primary.id);
      $("#cs-primary_color").attr('data-tooltip', primary.name)
                            .tooltip()
                            .removeAttr("class").addClass(primary.name).addClass('open-color-group').addClass('color-sample');

      $("#detail_color").val(detail.id);
      $("#cs-detail_color").attr('data-tooltip', detail.name)
                           .tooltip()
                           .removeAttr("class").addClass(detail.name).addClass('open-color-group').addClass('color-sample');

      $("#link_color").val(link.id);
      $("#cs-link_color").attr('data-tooltip', link.name)
                           .tooltip()
                           .removeAttr("class").addClass(link.name).addClass('open-color-group').addClass('color-sample');

      $("#text_color").val(text.id);
      $("#cs-text_color").attr('data-tooltip', text.name)
                           .tooltip()
                           .removeAttr("class").addClass(text.name).addClass('open-color-group').addClass('color-sample');

      $("#logo_color").val(logo.id);
      $("#cs-logo_color").attr('data-tooltip', logo.name)
                           .tooltip()
                           .removeAttr("class").addClass(logo.name).addClass('open-color-group').addClass('color-sample');

      $("#description_color").val(description.id);
      $("#cs-description_color").attr('data-tooltip', description.name)
                           .tooltip()
                           .removeAttr("class").addClass(description.name).addClass('open-color-group').addClass('color-sample');
    });
  });
});

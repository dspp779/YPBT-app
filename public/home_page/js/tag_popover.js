// add like count of tag when click on icon
function addLikeCount(){
  var tag = $(this);

  if ($(this).data("clicked") == 0)
  {
    var id = tag.attr("id")
    var like_count = tag.text()
    tag.get(0).lastChild.nodeValue = (+like_count + 1)
    $(this).data("clicked", "1")

    $.get('/timetag_add_one_like/' + id, function(){});
  }
}
$(".tag_like_count").click(addLikeCount);

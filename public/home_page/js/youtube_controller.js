// for hover into popover
var originalLeave = $.fn.popover.Constructor.prototype.leave;
$.fn.popover.Constructor.prototype.leave = function(obj) {
    var self = obj instanceof this.constructor ? obj : $(obj.currentTarget)[this.type](this.getDelegateOptions()).data('bs.' + this.type);
    originalLeave.call(this, obj);

    if (obj.currentTarget) {
        self.$tip.one('mouseenter', function() {
            clearTimeout(self.timeout);
            self.$tip.one('mouseleave', function() {
                $.fn.popover.Constructor.prototype.leave.call(self, self);
            });
        })
    }
};

// youtube player controllor
var tag = document.createElement('script');
tag.id = 'iframe-demo';
tag.src = 'https://www.youtube.com/iframe_api';
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
var player;
function onYouTubeIframeAPIReady() {
player = new YT.Player('ytplayer');
}

function seekTo(second){
  player.seekTo(second);
}
function test(){
    var duratime = player.getDuration();
    ttt = setInterval(print_time(),300);
}
function print_time(){
    var duration = player.getDuration();
    var point = document.getElementById('add-point');
    moveadd = function(){
        var progress = player.getCurrentTime()*100.0/duration;
        console.log(progress);
        point.style.left = progress+'%';
    }
    return moveadd;
}
// get tag detail when mouseenter
function loadDetail(){
 var tag = $(this);
 tag.off( "mouseenter mouseleave" );
 var id =tag.attr('id');
 var popotion = { container: 'body',
                  html: true,
                  placement:'auto bottom',
                  trigger:'hover',
                  delay: {show: 300, hide: 100}};
 $.get('/time_tag/'+id,function(data){
     popotion.content = data;
     tag.popover(popotion);
     if ( tag.filter(':hover').length > 0){
         tag.popover('toggle');
     }
 });
}
$(".tag-point").hover(loadDetail);

// click the like in time tag popover
function ajax_like_tag(id){
    $.ajax({
      type: 'PUT',
      url: '/timetag_add_one_like',
      data: { 'id': id },
    });
}
function add_like_count(id,count){
    count.text((+count.text()+1));
    ajax_like_tag(id);
}
function like_tag(like){
    like = $(like);
    if(!like.hasClass('liked')){
        like.removeClass('gray').addClass('liked');
        var tag_detail = like.parents('.tag-detail');
        var tag_id = tag_detail.attr('for');
        var tag_point = $('#'+tag_id);
        var count = tag_detail.find('span.like-count');
        add_like_count(tag_id,count);
        tag_point.data('bs.popover').options.content = tag_detail[0];
    }
    return false;
}

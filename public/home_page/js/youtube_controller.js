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

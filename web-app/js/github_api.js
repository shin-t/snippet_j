$(document.body).ready(function(){
    $(".dialog > .head > .value > a").each(function(index){
        console.log(index+":"+$(this).text());
    });
    $(".dialog").each(function(index){
        var url = 'https://api.github.com/gists/'+$(this).children(".head").children(".value").children("a").text()+'?callback=?';
        var obj = $(this).children(".body");
        $.getJSON(url,function(json){
            var data = json.data
            var content = $(
                '<div class="gist">'+
                '<p><a href="'+data.html_url+'">'+data.id+'</a></p>'+
                '<p>description:&nbsp;'+data.description+'</p>'+
                '<p>user login:&nbsp;'+data.user.login+'&nbsp;<img alt="Gravatar" class="gravatar" src="'+data.user.avatar_url+'"/></p>'+
                '<p>created at:&nbsp;'+data.created_at+',&nbsp;updated_at:&nbsp;'+data.updated_at+'</p>'+
                '</div>'+
                '<div class="files"></div>'
                );
            $(obj).append(content);
            var files = $(obj).children(".files");
            $.each(data.files,function(index){
                var f = $("<div/>",{"id":this.filename});
                f.append("<p/>");
                f.children("p").append($("<a/>",{text:this.filename,"href":this.raw_url}));
                var c = $("<p><pre><code></code></pre></p>");
                $(c).find("code").text(this.content);
                f.append(c);
                $(files).append(f);
            });
        });
    });
});

$(document.body).ready(function(){
    $(".dialog > .head > .value > a").each(function(index){
        console.log(index+":"+$(this).text());
    });
    $(".dialog").each(function(index){
        var url = 'https://api.github.com/gists/'+$(this).children(".head").children(".value").children("a").text()+'?callback=?';
        console.log(index+":"+url);
        var obj = $(this).children(".body");
        $.getJSON(url,function(json){
            console.log(json);
            var data = json.data
            var content = $(
                '<div class="gist">'+
                '<p><a href="'+data.html_url+'">'+data.id+'</a></p>'+
                '<p>description:&nbsp;'+data.description+'</p>'+
                '<p>user login:&nbsp;'+data.user.login+'&nbsp;<img style="width:16px; height:16px; border:solid 1px #ccc; padding:2px;" alt="Gravatar" class="gravatar" src="'+data.user.avatar_url+'"/></p>'+
                '<p>created at:&nbsp;'+data.created_at+',&nbsp;updated_at:&nbsp;'+data.updated_at+'</p>'+
                '</div>'+
                '<div class="files"></div>'
                );
            var files = $(content).children(".files");
            console.log(data.files);
            console.log(data.files.length);
            for(var file in data.files){
                console.log(data.files[file]);
                var f = $("<div/>",{"id":data.files[file].filename});
                f.append("<p/>");
                f.children("p").append($("<a/>",{text:data.files[file].filename,"href":data.files[file].raw_url}));
                var c = $("<p><pre><code></code></pre></p>");
                $(c).find("code").text(data.files[file].content);
                f.append(c);
                $(content).append(f);
            }
            $(obj).append(content);
        });
    });
});

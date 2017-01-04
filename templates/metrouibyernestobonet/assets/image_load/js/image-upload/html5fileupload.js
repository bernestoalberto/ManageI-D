/*
 * HTML5 File Upload
 * By STBeets
 * Purchase on http://codecanyon.net/item/html5-file-upload/9254506?ref=stbeets
 * Version 1.4.1
 */
function empty(e){
    var t,n,r,i;
    var s=[t,null,false,0,"",
        "0"];
    for(r=0,i=s.length;r<i;r++){
        if(e===s[r]){
            return true}
    }
    if(typeof e==="object"){
        for(n in e){
            return false}
        return true}
    return false}
function randString(e){
    if(!e){
        e=8}
    var t="";
    var n="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    for(var r=0;r<e;r++){
        t+=n.charAt(Math.floor(Math.random()*n.length))}
    return t}
(function(e,t,n){
    "use strict";
    t.html5fileupload=function(r,i){
        this.element=t(i);
        this.options=t.extend(true,{
            }
            ,
            t.html5fileupload.defaults,
            r,
            t(this.element).data()
        );
        this.input=t(this.element).find("input[type=file]");
        var s=t(e);
        var o=this;
        this.button={
        };
        this.button.edit='<div class="btn btn-info edit" id="btn_img_edit"><i class="glyphicon glyphicon-pencil"></i></div>';
        this.button.start='<div class="btn btn-success start" id="btn_img_start" ><i class="glyphicon glyphicon-play"></i></div>';
        this.button.restart='<div class="btn btn-success restart" id="btn_img_restart" ><i class="glyphicon glyphicon-repeat"></i></div>';
        this.button.cancel='<div class="btn btn-danger cancel" id="btn_img_candel"><i class="glyphicon glyphicon-ban-circle"></i></div>';
        this.button.reset='<div class="btn btn-warning reset" id="btn_img_reset"><i class="glyphicon glyphicon-refresh"></i></div>';
        this.button.remove='<div class="btn btn-danger remove" id="btn_img_remove"><i class="glyphicon glyphicon-remove"></i></div>';
        this.button.done='<div class="btn btn-success done" id="btn_img_done"><i class="glyphicon glyphicon-ok"></i></div>';
        this.button.del='<div class="btn btn-danger del" id="btn_img_del"><i class="glyphicon glyphicon-trash"></i></div>';
        this.button.download='<a class="btn btn-warning download" id="btn_img_download"><i class="glyphicon glyphicon-download"></i></a>';
        this.button.allstart='<div class="btn btn-success allstart" id="btn_img_allstart"><i class="glyphicon glyphicon-play-circle"></i> '+(this.options.labelAllStart||"")+"</div>";
        this.button.allstop='<div class="btn btn-warning allstop" id="btn_img_allstop"><i class="glyphicon glyphicon-record"></i> '+(this.options.labelAllStop||"")+"</div>";
        this.button.alldone='<div class="btn btn-info alldone" id="btn_img_alldone"><i class="glyphicon glyphicon-ok-circle"></i> '+(this.options.labelAllDone||"")+"</div>";
        this.button.allremove='<div class="btn btn-danger allremove" id="btn_img_allremove"><i class="glyphicon glyphicon-remove-circle"></i> '+(this.options.labelAllRemove||"")+"</div>";
        this.progressbar='<div class="progress"><div class="progress-bar progress-bar-success progress-bar-striped"></div></div>';
        this.files=[];
        this.filereader=[];
        this.xhrPool=[];
        o._init()
        return o;
    }
    ;
    t.html5fileupload.defaults={
        showErrors:false,
        url:null,
        downloadUrl:null,
        removeUrl:null,
        removeDone:false,
        removeDoneDelay:1200,
        file:null,
        edit:true,
        randomName:false,
        randomNameLength:8,
        form:false,
        data:{
        }
        ,
        ajax:true,
        ajaxType:"POST",
        ajaxDataType:"json",
        ajaxHeaders:{
        },
        multiple:false,
        validExtensions:null,
        validMime:null,
        labelInvalid:null,
        autostart:false,
        minFilesize:0,
        maxFilesize:2048e3,
        labelMinFilesize:null,
        labelMaxFilesize:null,
        regexp:/^[^\\/:\*\?"<>\|]+$/

    }
    ;
    t.html5fileupload.prototype={
        _init:function(){
            var e=this;
            var n=e.options;
            var r=e.element;
            var i=e.input;
            e.options.validExtensions=!empty(n.validExtensions)?n.validExtensions.split(","):null;
            //if(n.multiple!=false&&n.ajax==false){
            //    alert("This option is not valid! NOT TO BE IMPLEMENTED ERROR")
            //}
            if(n.multiple!=false){
                i.attr("multiple",
                    "multiple").wrap('<div class="add"></div>');
                r.addClass("empty");
                var s=t("<div></div>").addClass("multiple").hide();
                var o=t(e.button.allstart).unbind("click").hide().click(function(){
                        e.startAll()}
                );
                var u=t(e.button.allstop).unbind("click").hide().click(function(){
                        e.stopAll()}
                );
                var a=t(e.button.alldone).unbind("click").hide().click(function(){
                        e.removeDone()}
                );
                var f=t(e.button.allremove).unbind("click").click(function(){
                        e.removeAll()}
                );
                s.append(o).append(a).append(u).append(f);
                r.append(s)}
            if(!empty(n.file)){
                t.each(n.file.split(","),function(n,r){
                        var i=r.split("/");
                        var s={};
                        s.name=i[i.length-1];
                        s.size=0;
                        s.type=null;
                        s.original=r;
                        var o=e.addFile(s,true);
                        t(o).data("server-file",r)}
                );
                if(n.multiple==false){
                    t(i).hide()}
            }
            if(n.form){
                t(r).closest("form").keypress(function(e){
                        if(e.keyCode==13&&t(e.target).data("rename")==true){
                            return false}
                    }
                )}
            e._bind();
        }
        ,
        _bind:function(){
            //alert('bind');
            var e=this;
            var n=e.element;
            var r=e.input;
            t(n).unbind("dragover").unbind("drop").unbind("mouseout").on({
                    dragover:function(t){
                        e.handleDrag(t)}
                    ,drop:function(n){
                        e.handleFile(n,t(this))}
                    ,mouseout:function(){
                    }
                }
            );
            t(r).unbind("change").change(function(r){
                    e.drag=false;
                    e.handleFile(r,t(n))}
            )}
        ,
        handleFile:function(e,n){
            e.stopPropagation();
            e.preventDefault();
            var r=this;
            var i=r.options;
            var s=r.input;
            var o=r.drag==false?e.originalEvent.target.files:e.originalEvent.dataTransfer.files;
            r.drag=false;
            for(var u=0,a;a=o[u];u++){
                r.addFile(a);
                if(i.multiple!=true){
                    break}
            }
            if(i.form!=true){
                r._resetInput()}
            if(i.multiple==false){
                t(s).hide()}
        }
        ,
        handleDrag:function(e){
            var t=this;
            t.drag=true;
            e.stopPropagation();
            e.preventDefault();
            e.originalEvent.dataTransfer.dropEffect="copy"}
        ,
        addFile:function(e,n){
            var r=this;
            var i=r.element;
            var s=r.options;
            var o=r.input;
            var u=r.calcSize(e.size);
            var a=t("<div></div>").addClass("file");
            var f=e.name.split(".").pop();
            var l=e.name.substr(0,e.name.length-f.length-1);
            if(!empty(s.validExtensions)&&t.inArray(f,s.validExtensions)==-1){
                a.append(t("<div></div>").html(e.name).addClass("name"));
                a.append(t("<div></div>").html(s.labelInvalid||"File is not valid").addClass("notvalid"));
                a.append(t(r.progressbar).hide());
                var c=t(r.button.remove).addClass("remove").unbind("click").click(function(){
                        r.remove(t(this).closest(".file"))}
                );
                a.prepend(t("<div></div>").addClass("pull-right tools").append(c));
                r.element.append(a)}
            else if(!empty(s.validMime)&&!e.type.match(s.validMime)){
                a.append(t("<div></div>").html(e.name).addClass("name"));
                a.append(t("<div></div>").html(s.labelInvalid||"File is not valid").addClass("notvalid"));
                a.append(t(r.progressbar).hide());
                var c=t(r.button.remove).addClass("remove").unbind("click").click(function(){
                        r.remove(t(this).closest(".file"))}
                );
                a.prepend(t("<div></div>").addClass("pull-right tools").append(c));
                r.element.append(a)}
            else if(s.minFilesize!=null&&s.minFilesize>0&&e.size<s.minFilesize){
                var h=r.calcSize(s.minFilesize);
                a.append(t("<div></div>").html(e.name).addClass("name"));
                a.append(t("<div></div>").html(s.labelMinFilesize||"File is smaller then the minimum filesize ("+h.size+" "+h.label+")").addClass("notvalid"));
                a.append(t(r.progressbar).hide());
                var c=t(r.button.remove).addClass("remove").unbind("click").click(function(){
                        r.remove(t(this).closest(".file"))}
                );
                a.prepend(t("<div></div>").addClass("pull-right tools").append(c));
                r.element.append(a)}
            else if(s.maxFilesize!=null&&s.maxFilesize>0&&e.size>s.maxFilesize){
                var p=r.calcSize(s.maxFilesize);
                a.append(t("<div></div>").html(e.name).addClass("name"));
                a.append(t("<div></div>").html(s.labelMaxFilesize||"File is bigger then maximum filesize ("+p.size+" "+p.label+")").addClass("notvalid"));
                a.append(t(r.progressbar).hide());
                var c=t(r.button.remove).addClass("remove").unbind("click").click(function(){
                        r.remove(t(this).closest(".file"))}
                );
                a.prepend(t("<div></div>").addClass("pull-right tools").append(c));
                r.element.append(a)}
            else{
                t(i).find(".multiple").show();
                var d=false;
                if(s.multiple!=false&&r.files.length>0){
                    for(var v=0,m;m=r.files[v];v++){
                        if(e.name==m.name&&e.size==m.size&&e.type==m.type){
                            d=v;
                            break}
                    }
                }
                if(d!==false){
                    t(t(i).find(".file").get(d)).addClass("double").delay(500).queue(function(){
                            t(this).removeClass("double").clearQueue()}
                    );
                    return this}
                var g=t("<div></div>").addClass("inner");
                var y=null;
                var b=0;
                if(!empty(e.type)&&e.type.match("image.*")){
                    y=t("<div></div>").addClass("preview");
                    a.prepend(y);
                    var w=new FileReader;
                    w.onload=function(e){
                        return function(t){
                            y.css("background-image","url("+t.target.result+")").attr("title",e.name)
                        }
                    }
                    (e);
                    w.readAsDataURL(e);
                    w.name=arguments[0].name;
                    this.filereader.push(w);
                    b-=t(y).outerWidth()+10
                }
                if(s.randomName==true&&n!==true){
                    l=randString(s.randomNameLength)
                }
                g.append(t("<div></div>").html(l+"."+f).addClass("name"));
                g.append(t("<div></div>").html(u.size+" "+u.label).addClass("size"));
                a.append(g);
                a.append(t("<div></div>").addClass("clearfix"));
                r.element.append(a);
                if(n===true){
                    a.data("done",
                        true);
                    var E=t("<div></div>").addClass("pull-right tools");
                    var S=t(r.button.del).unbind("click").click(function(){
                            r.removeFile(t(this).closest(".file"))}
                    );
                    if(s.buttonDel!=false){
                        E.append(S)}
                    a.prepend(E);
                    b-=t(E).outerWidth();
                    if(t.inArray(f,["jpg","jpeg","png","gif","bmp"])!==-1){
                        y=t("<div></div>").addClass("preview");
                        y.css("background-image",
                            "url("+e.original+")");
                        a.prepend(y);
                        b-=t(y).outerWidth()+10}
                }
                else{
                    if(s.edit==true){
                        var x=t("<input />").attr({
                                type:"text",
                                name:t(o).attr("name")+"_name"}
                        ).data("rename",
                            true).val(l).addClass("form-control").keyup(function(e){
                                e.preventDefault();
                                e.stopImmediatePropagation();
                                e.stopPropagation();
                                t(this).parent().removeClass("has-error");
                                if(e.keyCode==13){
                                    r.editDone(t(this).closest(".file"))}
                                else if(e.keyCode==27){
                                    r.editCancel(t(this).closest(".file"))}
                            }
                        );
                        var T=t("<div></div>").html("."+f).addClass("extension").css({
                                marginTop:-Math.round(x.height()/2)}
                        );
                        g.append(t("<div></div>").append(x).append(T).addClass("input").hide())}
                    else if(s.edit==false&&s.form==true){
                        g.append(t("<input />").attr({
                                type:"text",
                                name:t(o).attr("name")+"_name"}
                        ).val(l).hide())}
                    g.append(t(r.progressbar).hide());
                    var N=t(r.button.start).unbind("click").click(function(){
                            r.start(t(this).closest(".file"))}
                    );
                    var c=t(r.button.remove).unbind("click").click(function(){
                            r.remove(t(this).closest(".file"))}
                    );
                    var C=t(r.button.edit).unbind("click").click(function(){
                            r.edit(t(this).closest(".file"))}
                    );
                    var E=t("<div></div>").addClass("pull-right tools");
                    if(s.buttonStart!=false&&!s.form){
                        E.append(N)}
                    if(s.buttonEdit!=false&&s.edit==true){
                        E.append(C)}
                    if(s.buttonRemove!=false){
                        E.append(c)}
                    a.prepend(E);
                    b-=t(E).outerWidth();
                    if(s.autostart){
                        E.children().hide()}
                    t(i).find(".multiple .allstart").show();
                    var k=r.files.push(e)-1}
                if(y){
                    b-=t(y).outerWidth()}
                b+=t(a).outerWidth();
                t(g).css({
                        width:b}
                );
                a.data({
                        originalFilename:l,
                        filename:l,
                        extension:f,
                        file:e.name,index:k
                    }
                );
                if(s.autostart&&n!==true){
                    r.start(t(a))}
            }
            return a}
        ,
        removeFile:function(e){
            var n=this;
            var r=n.options;
            e.find(".tools").hide();
            t.ajax({
                    url:r.removeUrl,type:r.ajaxType||"POST",
                    dataType:r.ajaxDataType||"json",
                    data:{
                        file:e.data("file")
                    }
                    ,headers:r.ajaxHeaders
                }
            ).done(function(i){
                    if(i.result==true){
                        n.remove(e)}
                    else{
                        if(r.showErrors==true){
                            e.find(".error").remove();
                            e.find(".inner").append(t('<div class="error text-danger"></div>').html("<strong>Error</strong>: "+ +i.status+" "+i.statusText))}
                        e.find(".tools").show()}
                }
            ).fail(function(n){
                    if(r.showErrors==true){
                        e.find(".e rror").remove();
                        e.find(".inner").append(t('<div class="error text-danger"></div>').html("<strong>Error</strong>: "+ +n.status+" "+n.statusText))}
                    e.find(".tools").show()}
            )}
        ,
        calcSize:function(e){
            if(e==0){
                return{
                    size:"",
                    label:""}
            }
            for(var t=["Kb","Mb","Pb","Eb","Zb","Yb"],n=0,r=e/1024;r>1e3;r/=1e3,n++){
            }
            return{
                size:r.toFixed(2),label:t[n]}
        }
        ,
        startAll:function(){
            var e=this;
            var n=e.options;
            var r=e.input;
            var i=e.element;
            var s=e.files;
            var o=i.find(".file");
            var u=t(i).find(".multiple");
            t(u).find(".allstart").hide();
            t(u).find(".allstop").show();
            for(var a=0,f;f=o[a];a++){
                e.start(t(f))}
            var l=setInterval(function(){
                    if(empty(e.xhrPool)){
                        t(u).find(".allstart").show();
                        t(u).find(".allstop").hide();
                        clearInterval(l)}
                }
                ,1e3)}
        ,
        stopAll:function(){
            var e=this;
            var n=e.element;
            t(e.xhrPool).each(function(e,t){
                    t.abort()}
            );
            e.xhrPool.length=0;
            var r=t(n).find(".multiple");
            t(r).find(".allstart").show();
            t(r).find(".allstop").hide()}
        ,
        removeDone:function(){
            var e=this;
            var n=e.element;
            t.each(n.find(".file"),function(n,r){
                    if(t(r).data("done")===true){
                        e.remove(t(this))
                    }
                }
            )}
        ,
        start:function(n,r){
            var i=this;
            var s=i.options;
            var o=i.input;
            var u=i.element;
            var a=i.files;
            var pos= i.files.length;
            r=a[n.data("index")];
            if(n.data("done")===true){
                return this
            }
            var f=n.find(".progress").show();
            t(f).find(".progress-bar").removeClass("progress-bar-info progress-bar-danger").addClass("active progress-bar-success").css("width",
                "0%");
            n.find(".tools").children().hide();
            if (i.options.onStart)
                i.options.onStart.call(i, e)
            var l = new FileReader;
            l.onloadend = function (r) {
                var o = t.ajax({
                        url: s.url, dataType: s.ajaxDataType || "json",
                        type: s.ajaxType || "POST",
                        cache: false, data: {
                            name: n.data("filename"),
                            filename: n.data("file"),
                            file: r.target.result,
                            data: s.data
                        },
                        headers: s.ajaxHeaders,
                        xhr: function () {
                            var n = new e.XMLHttpRequest;
                            n.upload.addEventListener("progress",
                                function (e) {
                                    if (e.lengthComputable) {
                                        t(f).find(".progress-bar").css("width",
                                            Math.round(e.loaded / e.total * 100) + "%")
                                    }
                                }, false);
                            return n
                        }, beforeSend: function (e) {
                            i.xhrPool.push(e);
                            n.find(".tools").append(t(i.button.cancel).click(function (e) {
                                    o.abort()
                                }
                            ))
                        }
                    }
                ).done(function (e) {
                        if (e.result == true)
                        {
                            t(f).find(".progress-bar").removeClass("active progress-bar-success").addClass("progress-bar-info").css("width",
                                "100%");
                            n.find(".tools").empty();
                            n.data("done",true);
                            if (s.removeDone == true) {
                                setTimeout(function () {
                                    i.remove(n)
                                }
                                    ,
                                    s.removeDoneDelay)
                            }
                            else {
                                t(u).find(".multiple .alldone").show();
                                if (s.buttonDownload != false) {
                                    n.find(".tools").append(t(i.button.download).attr({
                                            download: (s.downloadUrl || s.url) + "?" + n.data("file"),
                                            href: (s.downloadUrl || s.url) + "?" + n.data("file")
                                        }
                                    ))
                                }
                                if (s.buttonDone != false) {
                                    n.find(".tools").append(t(i.button.done).click(function (e) {
                                            i.remove(n)
                                        }
                                    ))
                                }
                            }

                            if (i.options.onAfterStartSuccess)
                                i.options.onAfterStartSuccess.call(i, e)
                        }
                        else {
                            if (s.showErrors == true) {
                                n.find(".error").remove();
                                n.find(".inner").append(t('<div class="error text-danger"></div>').html("<strong>Error</strong>: " + +e.status + " " + e.statusText))
                            }
                            t(f).find(".progress-bar").removeClass("active progress-bar-success").addClass("progress-bar-danger").css("width",
                                "100%");
                            n.find(".tools").empty().append(t(i.button.restart).click(function (e) {
                                    i.start(n)
                                }
                            )).append(t(i.button.remove).click(function () {
                                    i.remove(n)
                                }
                            ));
                            if (i.options.onAfterStartFail)
                                i.options.onAfterStartFail.call(i, e)
                        }

                    }
                ).fail(function (e) {
                        if (s.showErrors == true) {
                            n.find(".error").remove();
                            n.find(".inner").append(t('<div class="error text-danger"></div>').html("<strong>Error</strong>: " + +e.status + " " + e.statusText))
                        }
                        t(f).find(".progress-bar").removeClass("active progress-bar-success").addClass("progress-bar-danger").css("width",
                            "100%");
                        n.find(".tools").empty().append(t(i.button.restart).click(function (e) {
                                i.start(n)
                            }
                        )).append(t(i.button.remove).click(function () {
                                i.remove(n)
                            }
                        ));
                        if (i.options.onAfterStartFail)i.options.onAfterStartFail.call(i, e)
                    }
                ).complete(function (e) {
                        var t = i.xhrPool.indexOf(e);
                        if (t > -1) {
                            i.xhrPool.splice(t, 1)
                        }
                        if (i.options.onAfterStartAlways)i.options.onAfterStartAlways.call(i, response)
                    }
                )
            };
            l.readAsDataURL(r)
        }
        ,edit:function(e){
            var n=this;
            var r=n.options;
            var i=n.button;
            e.find(".inner").children().hide();
            e.find(".input").show();
            e.find(".input input").val(e.data("filename")).focus();
            e.find(".tools").children().toggle();
            var s=t(i.done).unbind("click").click(function(){
                    n.editDone(e)}
            );
            var o=t(i.cancel).unbind("click").click(function(){
                    n.editCancel(e)}
            );
            var u=t(i.reset).unbind("click").click(function(){
                    n.editReset(e)}
            );
            e.find(".tools").append(s).append(o).append(u);
            return n}
        ,editDone:function(e){
            var t=this;
            var n=t.options;
            var r=e.find(".input input").val();
            var i=/^\./;
            if(!n.regexp.test(r)||i.test(r)){
                e.find(".input").addClass("has-error");
                return this}
            e.find(".tools").children(":visible").remove();
            e.find(".tools").children().toggle();
            e.find(".input").hide();
            e.find(".name").show().html(e.find(".input input").val()+"."+e.data("extension"));
            e.find(".size").show();
            e.data("filename",
                e.find(".input input").val());
            return this}
        ,editCancel:function(e){
            e.find(".tools").children(":visible").remove();
            e.find(".tools").children().toggle();
            e.find(".input").hide();
            e.find(".name").show();
            e.find(".size").show()}
        ,editReset:function(e){
            e.find(".tools").children(":visible").remove();
            e.find(".tools").children().toggle();
            e.find(".input").hide();
            e.find(".name").show().html(e.data("originalFilename")+"."+e.data("extension"));
            e.find(".size").show();
            e.data("filename", e.data("originalFilename"))
        }
        ,remove:function(e){
            var n=this;
            var r=n.element;
            var i=n.input;
            e.remove();
            if(t(r).find(".file").length==0){
                n.reset()
            }
            if (n.options.onRemove)i.options.onRemove.call(n, response)
        }
        ,removeAll:function(){
            var e=this;
            var n=e.element;
            e.filereader=[];
            t.each(t(n).find(".file"),function(n,r){
                    if(t(r).data("done")===true){
                        e.removeFile(t(r))}
                    else{
                        e.remove(t(r))}
                }
            )}
        ,reset:function(){
            var e=this;
            var n=e.element;
            var r=e.input;
            e.files=[];
            e.filereader=[];
            e._resetInput();
            e.stopAll();
            t(n).children().not(r).not(".add").not(".multiple").remove();
            var i=t(n).find(".multiple").hide();
            t(i).find(".allstart").hide();
            t(i).find(".allstop").show()
        }
        ,_resetInput:function(){
            var e=this;
            var n=e.input;
            t(n).wrap("<form>").parent("form").trigger("reset");
            t(n).unwrap("<form>").show()
        }
    }
    ;
    t.fn.html5fileupload=function(e){
        if(t.data(this,"html5fileupload"))return;
        return t(this).each(function(){
                new t.html5fileupload(e,this);
                t.data(this,"html5fileupload")}
        )}
}
)(window,jQuery)
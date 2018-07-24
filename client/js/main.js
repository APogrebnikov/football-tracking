var svg;
var div;
var defs;

var width = 2000;
var height = 2000;
var widthField;
var heightField;
var currentGameId=0;

var restServer='http://localhost:57773/rest/football/';

var listOfCircles=[];
var listOfPoints=[
    {
        'x':10,
        'y':20,
        'radius':5,
        'name':'test',
        'speed':100
    },{
        'x':30,
        'y':50,
        'radius':5,
        'name':'test1',
        'speed':300
    },{
        'x':60,
        'y':80,
        'radius':5,
        'name':'test2',
        'speed':100
    },{
        'x':90,
        'y':100,
        'radius':5,
        'name':'test3',
        'speed':500
    },{
        'x':190,
        'y':150,
        'radius':5,
        'name':'test4',
        'speed':200
    },{
        'x':220,
        'y':300,
        'radius':5,
        'name':'test5',
        'speed':100
    },{
        'x':390,
        'y':390,
        'radius':5,
        'name':'test6',
        'speed':100
    },{
        'x':500,
        'y':390,
        'radius':5,
        'name':'test7',
        'speed':100
    },{
        'x':310,
        'y':30,
        'radius':5,
        'name':'test8',
        'speed':100
    },{
        'x':600,
        'y':500,
        'radius':5,
        'name':'test9',
        'speed':100
    },{
        'x':20,
        'y':200,
        'radius':5,
        'name':'test10',
        'speed':100
    },{
        'x':100,
        'y':500,
        'radius':5,
        'name':'test11',
        'speed':100
    },{
        'x':100,
        'y':20,
        'radius':5,
        'name':'test12',
        'speed':100
    },{
        'x':600,
        'y':300,
        'radius':5,
        'name':'test13',
        'speed':100
    }
];

function init(){
         
    svg = d3.select("#canvas").append("svg");

    svg.attr("height", height)
        .attr("width", width); 
    
    div = d3.select("body").append("div")	
        .attr("class", "tooltip")				
        .style("opacity", 0);
    
    defs = svg.append('svg:defs');
    
    // Патерн для поля
    defs
	.append('svg:pattern')
	.attr('id', 'gras-patt')
	.attr('patternUnits', 'userSpaceOnUse')
	.attr('width', '100')
	.attr('height', '100')
	.append('svg:image')
	.attr('xlink:href', 'https://thumbs.dreamstime.com/b/seamless-synthetic-grass-repeatable-texture-background-some-highlights-40411194.jpg')
	.attr('x', 0)
	.attr('y', 0)
	.attr('width', 100)
	.attr('height', 100);
    
    // Патерн для мяча
    defs.append("svg:pattern")
    .attr("id", "ball-pattern")
    .attr("width", 30) 
    .attr("height", 30)
    .attr("patternUnits", "objectBoundingBox")
    .append("svg:image")
    .attr("xlink:href", 'http://pngimg.com/uploads/football/football_PNG52734.png')
    .attr("width", 30)
    .attr("height", 30)
    .attr("x", 0)
    .attr("y", 0);

}

function createCircle(x,y,radius){
    var tempx=width*Math.random();
    var tempy=height*Math.random();
    var tempr=100*Math.random();
    
    
    var circle=svg.append("circle") 
            .attr("r", radius+tempr)
            .attr("fill",getRandomColor());
    
    circle.center={'x':x+tempx,'y':y+tempy};
    
    circle.on("mouseover", function(d) {
            d.oldcolor=d.attr('fill');
            d.attr("fill","#00ff00");
            div.transition()		
                .duration(200)		
                .style("opacity", .9);		
            div.html(Math.round(d.center.x)+" : "+Math.round(d.center.y) + "<br/> Hello")	
                .style("left", (d3.event.pageX) + "px")		
                .style("top", (d3.event.pageY - 28) + "px");	
    }.bind(this,circle));
    
    circle.on("mouseout", function(d) {	
            d.attr("fill",d.oldcolor);
            div.transition()		
                .duration(500)		
                .style("opacity", 0);	
    }.bind(this,circle));
    
    circle.on("click", function(d) {	
            circle.interrupt();	
    }.bind(this,circle));
    
    circle.append("text")
	    .attr("dx", function(d){return -20})
	    .text(function(d){return d.center.x+' : '+d.center.y}.bind(this,circle));
    
    //var randomX=width*Math.random();
    //var randomY=height*Math.random();
    
    repeat();
    
    function repeat() {
      circle
        .attr("cx", x+tempx)
        .attr("cy", y+tempy)
        .transition()
        .duration(2000*Math.random())
        .attr('cx', width*Math.random()) 
        .attr("cy", height*Math.random())
        .attr("fill",getRandomColor())
        .attr("opacity", 0.5)
        .transition()
        .duration(2000*Math.random())
        .attr("cx", x+tempx)
        .attr("cy", y+tempy)
        .attr("fill",getRandomColor())
        .attr("opacity", 1.0)
        .on("end", repeat);
    };
    
    /*
    setInterval(function(circle) {
        circle.center.x+=10;
        circle.attr("cx", circle.center.x);
    }.bind(this,circle), 10);
    */
    
    return circle;
}

function createCircleByPoint(point){
    
    var circle=svg.append("circle") 
            .attr("cx", point.x)
            .attr("cy", point.y)
            .attr("r", point.radius)
            .attr("fill",getRandomColor());
    circle.value=point;
    
    circle.on("mouseover", function(point) {		
            div.transition()		
                .duration(200)		
                .style("opacity", .9);		
            div.html("Hello "+point.value.name)	
                .style("left", (d3.event.pageX) + "px")		
                .style("top", (d3.event.pageY - 28) + "px");	
            }.bind(this,circle))					
        .on("mouseout", function(d) {		
            div.transition()		
                .duration(500)		
                .style("opacity", 0);	
        }.bind(this,circle));
    return circle;
}

function populate(count){
    for(var i=0; i<count; i++){
        listOfCircles.push(createCircle(10,10,25));
    }
    
    var dragHandler = d3.drag()
    .on("drag", function () {
        
        d3.select(this).interrupt()
            .attr("cx", d3.event.x)
            .attr("cy", d3.event.y);
    });

    dragHandler(svg.selectAll("circle"));
}

function generate(){
    svg.selectAll("*").remove();
    for(var i=0; i<listOfPoints.length; i++){
        listOfCircles.push(createCircleByPoint(listOfPoints[i]));
    }
    generateLine();
}

function moveByPoint(){
    
    var path = svg.select("path"),
    startPoint = pathStartPoint(path);
    
    var circle=svg.append("circle") 
        .attr("r", 15)
        .attr("fill",getRandomColor())
        .attr("transform", "translate(" + startPoint + ")");
    
    transition(circle,path);
}

function moveByRandomPoint(){
    
    var path = generateRandomPath();
    startPoint = pathStartPoint(path);
    
    var circle=svg.append("circle") 
        .attr("r", 15)
        .attr("id", "ball")
        //.attr("fill", getRandomColor())
        .attr("transform", "translate(" + startPoint + ")");
    
    transition(circle,path);
}

//==================ДвижSTART
function pathStartPoint(path) {
    var d = path.attr("d"),
    dsplitted = d.split(" ");
    return dsplitted[0].split(",")[0].replace('M','');
}

function transition(circle,path) {
    if (circle){
        circle.transition()
            .duration(10000)
            .attrTween("transform", translateAlong(path.node()))
            .on("end", transition);
    }
}

function translateAlong(path) {
    var l = path.getTotalLength();
    return function(i) {
      return function(t) {
        var p = path.getPointAtLength(t * l);
        return "translate(" + p.x + "," + p.y + ") rotate("+((Math.random() - 0.5) * 2 * 180)+")";
      }
    }
}
//==================ДвижEND

function generateLine(){
    var line = d3.line()
            .x(function(d){return d.x;})
            .y(function(d){return d.y;}); 
    
    svg.append("path").attr("d", line(listOfPoints))
        .attr("stroke", "blue")
        .attr("stroke-width", 0)
        .attr("fill", "none");
}

//==================Генерация поля START
function generateField(width,height){
    widthField = width;
    heightField = height;
    //Отспуты
    var mar=20;
    
    var field = svg.append("rect")
        .attr('id', 'field-main')
        .style("stroke", "white")
        .style("stroke-width", "2")
        .attr("x", 0)
        .attr("y", 0)
        .attr("width", width) 
        .attr("height", height)
        .attr("rx", 5);
    
    var fieldInner = svg.append("rect")
        .style("fill", "none")
        .style("stroke", "white")
        .style("stroke-width", "2")
        .attr("x", mar)
        .attr("y", mar)
        .attr("width", width-mar*2) 
        .attr("height", height-mar*2)
        .attr("rx", 5);
    
    var gateAreaLeft = svg.append("rect")
        .style("fill", "none")
        .style("stroke", "white")
        .style("stroke-width", "2")
        .attr("x", mar)
        .attr("y", (height/2)-200)
        .attr("width", 160) 
        .attr("height", 400);
    
    var gateLeft = svg.append("rect")
        .style("fill", "none")
        .style("stroke", "white")
        .style("stroke-width", "2")
        .attr("x", mar)
        .attr("y", (height/2)-90)
        .attr("width", 55) 
        .attr("height", 180);
    
    var circleLeft = svg.append("circle")     
        .style("fill", "white")
        .style("stroke", "white")
        .style("stroke-width", "1")
        .attr("cx", mar+110)
        .attr("cy", height/2)
        .attr("r", 5);
    
    var gateAreaRight = svg.append("rect")
        .style("fill", "none")
        .style("stroke", "white")
        .style("stroke-width", "2")
        .attr("x", width-(160+mar))
        .attr("y", (height/2)-200)
        .attr("width", 160) 
        .attr("height", 400);
    
    var gateRight = svg.append("rect")
        .style("fill", "none")
        .style("stroke", "white")
        .style("stroke-width", "2")
        .attr("x", width-(55+mar))
        .attr("y", (height/2)-90)
        .attr("width", 55) 
        .attr("height", 180);
    
    var circleRight = svg.append("circle")     
        .style("fill", "white")
        .style("stroke", "white")
        .style("stroke-width", "1")
        .attr("cx", width-(mar+110))
        .attr("cy", height/2)
        .attr("r", 5);

    var center = svg.append("line")
        .style("stroke", "white")
        .style("stroke-width", "4")
        .attr("x1", width/2)
        .attr("y1", mar)
        .attr("x2", width/2)
        .attr("y2", height-mar)
        .attr("rx", 5);
    
    var circle = svg.append("circle")     
        .style("fill", "none")
        .style("stroke", "white")
        .style("stroke-width", "4")
        .attr("cx", width/2)
        .attr("cy", height/2)
        .attr("r", 90);
    
    var circlecenter = svg.append("circle")     
        .style("fill", "white")
        .style("stroke", "white")
        .style("stroke-width", "4")
        .attr("cx", width/2)
        .attr("cy", height/2)
        .attr("r", 10);
}
//==================Генерация поля END
      
//Генерируем рандомную траекторию в рамках поля
function generateRandomPath(){
    var line = d3.line()
            .x(function(d){return d.x;})
            .y(function(d){return d.y;}); 
    
    var newRandomPointList=generateRandomPoints();
    
    var pathNew=svg.append("path").attr("d", line(newRandomPointList))
        .attr("stroke", "blue")
        .attr("stroke-width", 0)
        .attr("fill", "none");
    
    return pathNew;
}

function generateRandomPoints(){
    var count=50*Math.random();
    var result=[];
    for(var i=0;i<count;i++)
    {
        var x=(widthField-40)*Math.random();
        var y=(heightField-40)*Math.random();
        var point={'x':x,'y':y};
        result.push(point);
    }
    return result;
}

function createCircleForCheck(){
    svg.selectAll("#selCircle").remove();
    
    var x = $('#tbX').val();
    var y = $('#tbY').val();
    var r = $('#tbR').val();
    
    var circle=svg.append('circle') 
        .attr('id', 'selCircle')
        .attr('cx', x)
        .attr('cy', y)
        .attr('r', r)
        .attr('stroke', 'white')
        .attr('stroke-width', 2)
        .attr('stroke-dasharray', '5,5')
        .attr('fill-opacity',.2)
        .attr('fill','red');
        //.style('opacity', .2) 
    
    var dragHandler = d3.drag().on("drag", function () {
        d3.select(this).interrupt()
            .attr("cx", d3.event.x)
            .attr("cy", d3.event.y);
        $('#tbX').val(d3.event.x);
        $('#tbY').val(d3.event.y)
    });

    dragHandler(svg.selectAll("#selCircle"));
}


function getRandomColor() {
  var letters = '0123456789ABCDEF';
  var color = '#';
  for (var i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}

//===REST API
//Получение списка всех игр
function loadAllGames(){
    var xhr = new XMLHttpRequest();
    xhr.open('GET', restServer+'get/games', false);
    xhr.send();

    if (xhr.status != 200) {
        console.error( xhr.status + ': ' + xhr.statusText );
    } else {
        console.log(xhr.responseText);
        pushGamesTable(JSON.parse(xhr.responseText));
    }
}

function pushGamesTable(list){
    var table=$('#tbGames');
    for(var i=0;i<list.length;i++)
    {
        var tr=$('<tr></tr>');
        var tdId=$('<td>'+list[i].matchId+'</td>');
        var tdTeam1=$('<td>'+list[i].hostTeam+'</td>');
        var tdTeam2=$('<td>'+list[i].guestTeam+'</td>');
        
        tr.on('click',function(game){
            getPassesForGame(game.id);
        }.bind(this,list[i]));
        
        tr.append(tdId);
        tr.append(tdTeam1);
        tr.append(tdTeam2);
        table.append(tr);
    }
}

//Получение списка всех пассов в игре
function getPassesForGame(gameId){
    currentGameId=gameId;
    var xhr = new XMLHttpRequest();
    xhr.open('GET', restServer+'get/points/'+gameId, false);
    xhr.send();

    if (xhr.status != 200) {
        console.error( xhr.status + ': ' + xhr.statusText );
    } else {
        console.log(xhr.responseText);
        var allPasses=JSON.parse(xhr.responseText);
        var points=[];
        for(var i=0;i<allPasses.length;i++)
        {
            var point1={};
            point1.x=allPasses[i].startX;
            point1.y=allPasses[i].startY;
            point1.player=allPasses[i].fromPlayer;
            points.push(point1);
            
            var point2={};
            point2.x=allPasses[i].endX;
            point2.y=allPasses[i].endY;
            point2.player=allPasses[i].toPlayer;
            points.push(point2);
        }
    }
}

//Получение списка всех пассов пересекающих круг
function getPassesCheck(){
    var x = $('#tbX').val();
    var y = $('#tbY').val();
    var r = $('#tbR').val();
    
    var xhr = new XMLHttpRequest();
    xhr.open("POST", restServer+'check/round/'+currentGameId, true);
    xhr.setRequestHeader('Content-Type', 'application/json');
    xhr.send(JSON.stringify({cx:x, cy:y,r:r}));

    if (xhr.status != 200) {
        console.error( xhr.status + ': ' + xhr.statusText );
    } else {
        console.log(xhr.responseText);
        var allPasses=JSON.parse(xhr.responseText);
        var points=[];
        for(var i=0;i<allPasses.length;i++)
        {
            var point1={};
            point1.x=allPasses[i].startX;
            point1.y=allPasses[i].startY;
            point1.player=allPasses[i].fromPlayer;
            points.push(point1);
            
            var point2={};
            point2.x=allPasses[i].endX;
            point2.y=allPasses[i].endY;
            point2.player=allPasses[i].toPlayer;
            points.push(point2);
        }
    }
}
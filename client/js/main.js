var svg;
var div;
var width = 2000;
var height = 2000;
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
        'x':750,
        'y':780,
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

//==================ДвижSTART
function pathStartPoint(path) {
    var d = path.attr("d"),
    dsplitted = d.split(" ");
    return dsplitted[0].split(",");
}

function transition(circle,path) {
    circle.transition()
        .duration(7500)
        .attrTween("transform", translateAlong(path.node()))
        .each("end", transition);
}

function translateAlong(path) {
    var l = path.getTotalLength();
    return function(i) {
      return function(t) {
        var p = path.getPointAtLength(t * l);
        return "translate(" + p.x + "," + p.y + ")";
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
                  
function getRandomColor() {
  var letters = '0123456789ABCDEF';
  var color = '#';
  for (var i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/inc_header.jsp" %>
<!DOCTYPE html>
<style>
.category-list-content{
	width:200px;
	font-size: 20px;
	border: 1px solid black;
	text-align: center;
	cursor: pointer;
	margin: 3px;
}
#categoryFrame{
	display:none;
}
.clicked{
	background-color: gray;
}
</style>
<div>
	<div class="category-list">
		<c:set value="1" var="i"/>
		<c:forEach var="category" items="${categoryList}">
			<div class="category-list-content" id="category${i}" draggable="true">
				<input type="hidden" name="name" value="${category}">
				<input type="hidden" name="preOrder" value="">
				<input type="hidden" value="mod">
				${category}
			</div>
			<c:set var="i" value="${i+1}"/>
		</c:forEach>
		<div class="category-list-content" id="insertTarget">카테고리 목록</div>
	</div>

	<div>
		<input type="text" id="newName">
		<button type="button" onclick="addCategory();">카테고리 추가</button>
		<div>
			<button type="button" onclick="deleteSelected();">카테고리 삭제</button>
			<button type="button" onclick="saveChange();">저장</button>
			<button type="button" onclick="location.reload();">취소</button>
		</div>
	</div>
</div>

<div id="categoryFrame">
	<div class="category-list-content" draggable="true">
		<input type="hidden" name="name" value="">
		<input type="hidden" name="preOrder" value="">
		<input type="hidden" value="add">
	</div>
</div>
<script>

var insertDiv = document.querySelector("#insertTarget");
var draggable = document.querySelectorAll(".category-list-content");
var parent = document.querySelector(".category-list");

draggable.forEach(elem => {
	
	elem.addEventListener('dragover', function(event){
		event.preventDefault();	
	});
	
	if(elem != insertDiv){
		elem.addEventListener("click", function(){
			elem.classList.toggle("clicked");
		});
	}
	
	elem.addEventListener('dragstart', function(event){
		event.dataTransfer.setData("selCategory", event.target.id);
	});
	
	elem.addEventListener("dragenter", function(event){
		event.preventDefault();	
		event.target.style.borderTop = "1px solid red";
	});
	elem.addEventListener("dragleave", function(event){
		event.target.style.borderTop = "1px solid black";
	});
	elem.addEventListener("dragend", function(event){
		event.target.style.borderTop = "1px solid black";
	});
	elem.addEventListener("drop", function(event){
		event.target.style.borderTop = "1px solid black";
		var id = event.dataTransfer.getData("selCategory");
		var selElem = document.getElementById(id);
		parent.insertBefore(selElem, event.target);
	});
	
});


function deleteSelected(){
	var selectedNames = document.querySelectorAll(".clicked input[name=name]");
	var nameString = "";
	selectedNames.forEach(elem => nameString += elem.value+",");
	nameString = nameString.substring(0, nameString.length-1);
	console.log(nameString);
	var xhr = new XMLHttpRequest(); 
    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
        	alert(xhr.responseText);
        	location.reload();
           }
        }
    };
    xhr.open("POST", "delete");
    xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xhr.send("names="+nameString);
	
	console.log(nameString);
}

function addEvent(elem){
	
	elem.addEventListener('click', function(){
		elem.classList.toggle("clicked");
	});
	
	elem.addEventListener('dragover', function(event){
		event.preventDefault();	
	});
	
	elem.addEventListener('dragstart', function(event){
		event.dataTransfer.setData("selCategory", event.target.id);
		console.log(event.target.id);
	});
	elem.addEventListener("dragenter", function(event){
		event.preventDefault();	
		event.target.style.borderTop = "1px solid red";
	});
	elem.addEventListener("dragleave", function(event){
		event.target.style.borderTop = "1px solid black";
	});
	elem.addEventListener("dragend", function(event){
		event.target.style.borderTop = "1px solid black";
	});
	elem.addEventListener("drop", function(event){
		event.target.style.borderTop = "1px solid black";
		var id = event.dataTransfer.getData("selCategory");
		var selElem = document.getElementById(id);
		parent.insertBefore(selElem, event.target);
	});
}


var index = ${i};

function addCategory(){
	var frame = document.querySelector("#categoryFrame").children[0];
	var newName = document.querySelector("#newName");
	var printName = frame;
	var inputName = frame.children[0];
	var inputPreOrder = frame.children[1];
	
	printName.text = newName.value;
	inputName.value = newName.value;
	inputPreOrder.value = index;
	frame.id = "category"+index;
	newName.value = "";
	
	var createdFrame = frame.cloneNode(true);
	addEvent(createdFrame);
	parent.insertBefore(createdFrame, insertDiv);
	
	index += 1;
}

function saveChange(){
	var array = [];
	var listContent = parent.children;
	for(var i=0; i<listContent.length-1; i++){
		var data = new Object();
		var name = listContent[i].children[0].value;
		var preOrder = listContent[i].children[1].value = i;
		var addModChk = listContent[i].children[2].value;
		data.name = name;
		data.preOrder = preOrder;
		if(addModChk == 'add'){
			array.push({"add":data});
		}else{
			array.push({"mod":data});
		}
	}
	var dataArray = JSON.stringify(array);
	var xhr = new XMLHttpRequest(); 
    xhr.onreadystatechange = function() {
      if (xhr.readyState === 4) {
        if (xhr.status === 200) {
        	alert(xhr.responseText);
           }
        }
    };
    xhr.open("POST", "modify");
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send(dataArray);
}

</script>
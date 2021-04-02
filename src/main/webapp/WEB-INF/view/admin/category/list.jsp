<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/view/inc/inc_header.jsp" %>
<!DOCTYPE html>
<style>
.category-list-content{
	width:300px;
	font-size: 20px;
	border: 1px solid black;
	text-align: center;
	cursor: pointer;
	margin: 3px;
	position: relative;
}
#categoryFrame{
	display:none;
}
.clicked{
	background-color: gray;
}
.hidden{
	display:none;
}
.mod-btn{
	position: absolute;
	right: 20px;
	top: 2px;
}
</style>
<div>
	<div class="category-list">
		<c:set value="1" var="i"/>
		<c:forEach var="category" items="${categoryList}">
		<div class="category-list-content" id="category${i}" draggable="true">
			<input type="hidden" name="name" value="${category.name}">
			<input type="hidden" name="preOrder" value="">
			<input type="hidden" value="mod">
			<input type="hidden" name="no" value="${category.no}">
			<div class="category-name-div">${category.name}</div>
			<button type="button" class="hidden mod-btn" onclick="modCategory();">수정</button>
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
		<input type="hidden" name="no" value="">
		<div class="category-name-div"></div>
		<button type="button" class="hidden mod-btn" onclick="modCategory();">수정</button>
	</div>
</div>
<script>

var insertDiv = document.querySelector("#insertTarget");
var draggable = document.querySelectorAll(".category-list-content");
var parent = document.querySelector(".category-list");
var nameDiv = document.querySelectorAll(".category-name-div");

draggable.forEach(elem => {
	
	elem.addEventListener('dragover', function(event){
		event.preventDefault();	
	});
	
	if(elem != insertDiv){
		elem.addEventListener("click", function(event){
			elem.classList.toggle("clicked");
		});
		
		elem.addEventListener('mouseover', function(){
			elem.children[5].classList.toggle("hidden");
		});
		
		elem.addEventListener('mouseout', function(){
			elem.children[5].classList.toggle("hidden");
		});
	}
	
	elem.addEventListener('dragstart', function(event){
		event.dataTransfer.setData("selCategory", this.id);
	});
	
	elem.addEventListener("dragenter", function(event){
		event.preventDefault();	
		this.style.borderTop = "1px solid red";
	});
	elem.addEventListener("dragleave", function(event){
		this.style.borderTop = "1px solid black";
	});
	elem.addEventListener("dragend", function(event){
		this.style.borderTop = "1px solid black";
	});
	elem.addEventListener("drop", function(event){
		this.style.borderTop = "1px solid black";
		var id = event.dataTransfer.getData("selCategory");
		var selElem = document.getElementById(id);
		parent.insertBefore(selElem, this);
	});
	
});

function modCategory(){
	event.stopPropagation();
	var targetDiv = event.target.parentNode.children[4];
	
	targetDiv.setAttribute("contentEditable","true");
	targetDiv.focus();
	var nameLength = targetDiv.innerText.length;
	
	// focus 커서 위치 조정
	var range = document.createRange();
    var sel = window.getSelection();
    range.setStart(targetDiv.childNodes[0], nameLength);
    range.collapse(true);
    sel.removeAllRanges();
    sel.addRange(range);
    
	event.target.innerText = "확인";
	event.target.onclick = confirmMod;
}

function confirmMod(){
	event.stopPropagation();
	var targetInput = event.target.parentNode.children[0];
	var targetDiv = event.target.parentNode.children[4];
	targetDiv.removeAttribute("contentEditable");
	targetInput.value = targetDiv.innerText;
	event.target.innerText = "수정";
	event.target.onclick = modCategory;
}


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
	
	elem.addEventListener('mouseover', function(){
		elem.children[5].classList.toggle("hidden");
	});
	
	elem.addEventListener('mouseout', function(){
		elem.children[5].classList.toggle("hidden");
	});
	
	elem.addEventListener('dragover', function(event){
		event.preventDefault();	
	});
	
	elem.addEventListener('dragstart', function(event){
		event.dataTransfer.setData("selCategory", this.id);
		console.log(this.id);
	});
	elem.addEventListener("dragenter", function(event){
		event.preventDefault();	
		this.style.borderTop = "1px solid red";
	});
	elem.addEventListener("dragleave", function(event){
		this.style.borderTop = "1px solid black";
	});
	elem.addEventListener("dragend", function(event){
		this.style.borderTop = "1px solid black";
	});
	elem.addEventListener("drop", function(event){
		this.style.borderTop = "1px solid black";
		var id = event.dataTransfer.getData("selCategory");
		var selElem = document.getElementById(id);
		parent.insertBefore(selElem, this);
	});
}


var index = ${i};

function addCategory(){
	var frame = document.querySelector("#categoryFrame").children[0];
	var newName = document.querySelector("#newName");
	
	var createdFrame = frame.cloneNode(true);
	var inputName = createdFrame.children[0];
	var inputPreOrder = createdFrame.children[1];
	var nameDiv = createdFrame.children[4];
	
	nameDiv.innerText = newName.value;
	inputName.value = newName.value;
	inputPreOrder.value = index;
	createdFrame.id = "category"+index;
	
	newName.value = "";
	
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
		var no = listContent[i].children[3].value;
		data.name = name;
		data.preOrder = preOrder;
		data.no = no;
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
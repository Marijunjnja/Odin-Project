const container = document.querySelector('#container');
const body = document.querySelector('body');

const button = document.createElement('button');
button.textContent = 'Clear and Specify Dimensions';
button.classList.add('clear');
body.appendChild(button);

function createSquares(squaresPerSide, squareWidth) {
		
	for (let i = 0; i < (squaresPerSide * squaresPerSide); i++) {
  	let square = document.createElement('div');
  	square.classList.add('square');
		square.style.width = squareWidth;
		square.style.height = square.style.width;
  	container.appendChild(square);
	}
	
}

function initializeSquares() {
	let squareWidth = calculateSquareWidth(4);
	console.log("initialize: " + squareWidth);
	createSquares(4, squareWidth);
}

function removeSquares() {
	
	let myNode = document.getElementById('container');
	while (myNode.firstChild) {
		myNode.removeChild(myNode.firstChild);
	};
	
}

function calculateSquareWidth(squaresPerSide) {
	
	let containerWidth = getContainerWidth();
	console.log("container width: " + containerWidth);
	let squareWidth = containerWidth / (squaresPerSide);
	squareWidth = squareWidth.toString() + 'px';
	return squareWidth;
}

function getContainerWidth() {
	return $('#container').width();
}

function activateSquares() {
	let squares = document.querySelectorAll('.square');
	squares.forEach((square) => {
	
		$(square).hover(function() {
			$(this).addClass("active");
			$(this).css('background', getColor());
			/*if (option == 'rainbow') {
				$(this).css('background', getColor());
			} else if (option == 'pencil') {
				$
			} else {
				$(this).css('background', "#000");
			}*/
		});
	});
}

$('button').click(function() {
	removeSquares();
	let squaresPerSide = parseInt(prompt("How many squares per side would you like to have?\nPick a number < 56"));
	while (squaresPerSide) { 
		if (squaresPerSide > 56) {
			squaresPerSide = parseInt(prompt("Too many squares specified. Please choose a number below 100"));
		} else {
			break;
		}
	}
	let squareWidth = calculateSquareWidth(squaresPerSide);
	createSquares(squaresPerSide, squareWidth);
	activateSquares();
});

$(document).ready(function() {
	initializeSquares();
	activateSquares();
});

function getColor() {
	let red = Math.floor(Math.random() * 256);	
	let green = Math.floor(Math.random() * 256);
	let blue = Math.floor(Math.random() * 256);
	let color = "rgb(" + red + ", " + green + ", " + blue + ")";
	return color;
}


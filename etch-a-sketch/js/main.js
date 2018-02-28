const container = document.querySelector('#container');

for (let i = 0; i < 16; i++) {
  const square = document.createElement('div');
  square.classList.add('square');
  square.style.cssText = 'height: 250px; width: 250px; border: solid black 1px';
  container.appendChild(square);
}



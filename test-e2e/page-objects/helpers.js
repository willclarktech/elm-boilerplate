export function getClassList(selector) {
  const className = document
    .querySelector(selector)
    .getAttribute('class');

  return className
    ? className.split(' ')
    : [];
}

export function getText(selector) {
  return document
    .querySelector(selector)
    .innerText;
}

export function getAllTexts(selector) {
  return Array.prototype.map.call(
    document.querySelectorAll(selector),
    element => element.innerText
  );
}

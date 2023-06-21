/**
 * 
 */
let slides = document.querySelector('.slides');
let slideImg = document.querySelectorAll('.slides li');
currentIdx = 0;
slideCount = slideImg.length;
prev = document.querySelector('.prev'); //이전 버튼
next = document.querySelector('.next'); //다음 버튼
slideWidth = 1123; //슬라이드 이미지 넓이
slideMargin = 500; //슬라이드 끼리의 마진 값
makeCloneSlide(); // 이미지 복제 함수 호출
initFunction(); //슬라이드 넓이와 위치값 초기화 함수

function makeCloneSlide() {
  for (let i = 0; i < slideCount; i++) {
    let cloneSlide = slideImg[i].cloneNode(true);
    slides.appendChild(cloneSlide);
  }
}

function initFunction() {
  slides.style.width = (slideWidth + slideMargin) * (slideCount + 2) + 'px';
  slides.style.left = -(slideWidth + slideMargin) + 'px';
}

next.addEventListener('click', function () {
  //다음 버튼 눌렀을 때
  if (currentIdx < slideCount) {
    //슬라이드 이동
    slides.style.left = -(currentIdx + 1) * (slideWidth + slideMargin) + 'px';
    slides.style.transition = `${0.5}s ease-out`; //이동 속도
    currentIdx++;
  } else {
    setTimeout(function () {
      //마지막 슬라이드에서 첫 번째 슬라이드로 이동
      slides.style.left = -(slideWidth + slideMargin) + 'px';
      slides.style.transition = `${0}s ease-out`;
      currentIdx = 0;
    }, 500);
  }
});

prev.addEventListener('click', function () {
  //이전 버튼 눌렀을 때
  if (currentIdx > 0) {
    currentIdx--;
    slides.style.left = -(currentIdx * (slideWidth + slideMargin)) + 'px';
    slides.style.transition = `${0.5}s ease-out`;
  } else {
    setTimeout(function () {
      //첫 번째 슬라이드에서 마지막 슬라이드로 이동
      slides.style.left = -(slideCount * (slideWidth + slideMargin)) + 'px';
      slides.style.transition = `${0}s ease-out`;
      currentIdx = slideCount;
    }, 500);
  }
});

function goPage(seq, thumbnail) {
  // 폼 생성 및 설정
  var form = document.createElement("form");
  form.method = "post";
  form.action = "board/exhibition/exhibitionDetail.jsp";

  // seq 값을 전송할 숨겨진 input 필드 생성
  var seqInput = document.createElement("input");
  seqInput.type = "hidden";
  seqInput.name = "seq";
  seqInput.value = seq;
  form.appendChild(seqInput);

  // thumbnail 값을 전송할 숨겨진 input 필드 생성
  var thumbnailInput = document.createElement("input");
  thumbnailInput.type = "hidden";
  thumbnailInput.name = "thumb";
  thumbnailInput.value = thumbnail;
  form.appendChild(thumbnailInput);

  // 폼을 body에 추가하고 전송
  document.body.appendChild(form);
  form.submit();
}
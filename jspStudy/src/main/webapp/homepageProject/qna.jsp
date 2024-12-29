<%@ page contentType="text/html; charset=UTF-8"%>
<main>
    <h1>고객센터 Q&A</h1>
    <div class="faq">
        <h2>자주 묻는 질문</h2>
        
        <div class="faq-item">
            <strong>Q: 회원가입은 어떻게 하나요?</strong>
            <div class="answer">
                A: 회원가입은 홈페이지 우측의 '회원가입' 버튼을 클릭하여 필요한 정보를 입력하면 됩니다.
            </div>
        </div>

        <div class="faq-item">
            <strong>Q: 비밀번호를 잊어버렸어요. 어떻게 해야 하나요?</strong>
            <div class="answer">
                A: 비밀번호를 잊으셨다면, 홈페이지 우측의 '비밀번호 찾기'를 클릭하여 아이디, 전화번호, 이메일을 입력하시면 비밀번호를 찾으실 수 있습니다.
            </div>
        </div>

        <div class="faq-item">
            <strong>Q: 게시판 이용수칙이 있을까요?</strong>
            <div class="answer">
                A: 홈페이지 좌측의 공지사항에 적혀있습니다.
            </div>
        </div>

        <div class="faq-item">
            <strong>Q: 쇼핑몰 페이지를 어떻게 찾아야 할까요?</strong>
            <div class="answer">
                A: 홈페이지 상단에 서비스를 누르시면 쇼핑몰로 이동할수 있습니다.
            </div>
        </div>

        <div class="faq-item">
            <strong>Q: 상품을 구매했는데 장바구니 위치를 어떻게 찾을까요?</strong>
            <div class="answer">
                A: '마이 페이지'에서 장바구니를 찾으시고, 바로 구매 가능하십니다.
            </div>
        </div>

        <div class="faq-item">
            <strong>Q: 결제 방법은 무엇인가요?</strong>
            <div class="answer">
                A: 금액을 충전하시면 비용에서 차감됩니다. 금액은 마이페이지에서 충전하실 수 있습니다.
            </div>
        </div>
        
        <div class="faq-item">
              <a href="mainPage.jsp?flag=none">이전 페이지로</a>
        </div>

    </div>
</main>
<script>
    // FAQ 항목 클릭 시 답변 표시/숨기기
    document.querySelectorAll('.faq-item').forEach(item => {
        item.addEventListener('click', () => {
            const answer = item.querySelector('.answer');
            answer.style.display = (answer.style.display === 'block') ? 'none' : 'block';
        });
    });
</script>
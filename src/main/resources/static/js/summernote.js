const imageUploadUrl = "/app/sicdan/imageUpload";
const imageDeleteUrl = "/app/sicdan/imageDelete";
    $(document).ready(function() {
        $('.summernote').summernote({
            lang: 'ko-KR',
            height: 500,
            disableDragAndDrop: true,
            disableResizeEditor: true,
            toolbar: [
                ['fontname', ['fontname']],
                ['fontsize', ['fontsize']],
                ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
                ['color', ['forecolor']],
                ['table', ['table']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
            ],
            fontNames: ['Arial', 'Arial Black', 'Comic Sans MS', 'Courier New','sans-serif' ,'맑은 고딕','궁서','굴림체','굴림','돋음체','바탕체'],
            fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72'],
            callbacks: {
				onChange: function (contents, $editable) {
				    // <font> 태그를 <span> 태그로 변환
				    let updatedContents = contents.replace(/<font(.*?)color="(.*?)">(.*?)<\/font>/g, function (match, fontAttrs, color, innerHTML) {
				        return `<span style="color:${color};">${innerHTML}</span>`;
				    });
				
				    // 중첩된 <span> 태그를 단일 태그로 병합
				    updatedContents = updatedContents.replace(/<span(.*?)style="(.*?)"><span(.*?)style="(.*?)">(.*?)<\/span><\/span>/g, function (
				        match,
				        outerAttrs,
				        outerStyle,
				        innerAttrs,
				        innerStyle,
				        innerContent
				    ) {
				        return `<span style="${outerStyle} ${innerStyle}">${innerContent}</span>`;
				    });
				
				    if (contents !== updatedContents) {
				        $('.summernote').summernote('code', updatedContents);
				    }
				},
				onInit: function () {
                $('.note-editable').css('text-align', 'left'); // 왼쪽 정렬로 설정
            	},
                onImageUpload: function(files) {
                    for (let i = 0; i < files.length; i++) {
                        uploadImage(files[i], this);
                    }
                }
            },
            
        });
    });
    // 이미지 업로드 함수
    function uploadImage(file, editor) {
        let data = new FormData();
        data.append("file", file);

        $.ajax({
            url: imageUploadUrl,
            type: "POST",
            data: data,
            contentType: false,
            processData: false,
            success: function(response) {
                // 이미지 URL을 Summernote에 삽입
                 console.log("Uploaded Image URL:", response);
                $(editor).summernote('insertImage', response);
            },
            error: function() {
                alert("이미지 업로드 실패");
            }
        });
    }
    // 이미지 삭제 함수
function deleteImage(src) {
    $.ajax({
        url: imageDeleteUrl,
        type: "POST",
        data: { fileUrl: src },
        success: function(response) {
            console.log("이미지 삭제 성공:", response);
        },
        error: function() {
            alert("이미지 삭제 실패");
        }
    });
}
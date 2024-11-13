const imageUploadUrl = "/app/sicdan/imageUpload";
const imageDeleteUrl = "/app/sicdan/imageDelete";
    $(document).ready(function() {
        $('.summernote').summernote({
            lang: 'ko-KR',
            height: 400,
            toolbar: [
                ['fontname', ['fontname']],
                ['fontsize', ['fontsize']],
                ['style', ['bold', 'italic', 'underline', 'strikethrough', 'clear']],
                ['color', ['forecolor', 'color']],
                ['table', ['table']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['height', ['height']],
                ['insert', ['picture', 'link', 'video']],
                ['view', ['fullscreen', 'help']]
            ],
            callbacks: {
                onImageUpload: function(files) {
                    for (let i = 0; i < files.length; i++) {
                        uploadImage(files[i], this);
                    }
                }
            }
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
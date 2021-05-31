<!doctype html>
<html>

<head>
    <meta charset='utf-8'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <title>{{"Dowload " . $nodes["filename"]}}</title>
    <link href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css' rel='stylesheet'>
    <link href='' rel='stylesheet'>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
            background-color: #eee
        }
        
        .container {
            display: flex;
            justify-content: center;
            margin-top: 200px;
            background: transparent
        }
        
        .trigger {
            background-color: green;
            color: #fff
        }
        
        .modal,
        .fade,
        .show {
            background-color: lightpink;
            padding-left: 15px;
            padding-right: 15px
        }
        
        h2 {
            font-weight: bold;
            margin-bottom: 15px;
            color: #000
        }
        
        .modal-content {
            border: none;
            background: transparent;
            padding: 0 19px
        }
        
        .close {
            position: relative;
            top: 48px;
            left: 13px;
            z-index: 1;
            font-size: 30px;
            font-weight: bold;
            line-height: 1;
            color: black
        }
        
        .modal-header {
            border: none
        }
        
        .modal-header .close {
            padding: 0rem 1rem !important;
            margin: -1rem -1rem -1rem auto
        }
        
        .modal-body {
            border: none;
            background-color: white;
            padding-bottom: 5px
        }
        
        .close.focus,
        .close:focus {
            outline: 0;
            box-shadow: none !important
        }
        
        .form-control {
            width: 80%;
            height: 50px;
            border: none;
            border-radius: 20px;
            box-shadow: 0px 0.5px 0px 0px #dae0e5 !important;
            color: #63686c;
            font-weight: bold;
            font-size: 12px
        }
        
        .form-control.focus {
            border: none;
            border-color: #fff;
            border-bottom: 1px solid #000;
            outline: 0;
            box-shadow: 0 0 0 0 rgba(0, 123, 255, .25)
        }
        
        @media (min-width:599px) {
            .modal-dialog {
                max-width: 47rem
            }
        
            .details {
                padding: 60px 0 40px 50px
	    }
        
            .text-muted a {
                color: #c0bfbf;
                font-weight: bold;
                text-decoration: underline
            }
        
            small.para {
                font-weight: bold;
                font-size: 14px;
		color: #63686c
            }
        }
    </style>
    <script type='text/javascript' src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js'></script>
    <script type='text/javascript' src='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js'></script>
    <script type='text/javascript'>
        window.onload=function(){
                                        document.getElementsByTagName("button")[0].click();
                                    }
    </script>
</head>

<body oncontextmenu='return false' class='snippet-body'>
    <div class='container'> <button type="button" class="btn btn-success btn-lg" data-toggle="modal" data-target="#exampleModal"> Download now </button>
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-body p-0 row">
                        <div class="col-12 col-lg-5 ad p-0"> <img src="{{ asset('img/img.jpg') }}" width="100%" height="100%" /> </div>
                        <div class="details col-12 col-lg-7">
                            <h4>{{"File Name: " . $nodes["filename"]}}</h4>
                            <p><small class="para">Please enter your email-id and name<br>to receive file in mail.</small></p>
                            <p><small class="para"> <br> </small></p>
			    <div class="form-group mt-3 pt-3 mb-5">
				<form action="{{ route('store') }}" method="POST" id="emailform">
					{{ csrf_field() }}	
					<input name="email" type="email" class="form-control" placeholder="email@example.com" required>
					<input name="f" type="hidden" value="{{$uid}}">	
					<input name="name" type="text" class="form-control" placeholder="Full Name" required>
				</form>
                            </div>
			    <small class="text-muted"><a href="#" onclick="document.getElementById('emailform').submit()">Download</a></small>
                        </div>
		    </div>
		<h4 style="color:red">Check your email spam folder too, if not received in inbox</h4>
                </div>
            </div>
        </div>
    </div>
</body>

</html>

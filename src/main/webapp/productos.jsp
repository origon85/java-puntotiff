<%@page import="modelo.Publicacion"%>
<%@page import="dao.PublicacionDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<!-- que sea responsive -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Archivo bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<!-- estilos css -->
<link rel="stylesheet" type="text/css" href="styles/style.css" />

<link rel="icon" type="image/png" href="img/logo punto tiff.png">
<title>Punto Tiff</title>

<!-- Agrego iconos de redes sociales -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.css">
</link>
<!-- Agregar album -->
<link rel="canonical"
	href="https://getbootstrap.com/docs/5.3/examples/album/">

</head>

<body>

	<%
           PublicacionDAO dao = new PublicacionDAO();
           List<Publicacion> publicacionesList = new ArrayList<Publicacion>();

       %>
	<div class="area-inicial">
		<!-- Inicio header -->
		<header class="header_section">
			<div class="container-fluid">
				<nav class="navbar navbar-expand-lg custom_nav-container">
					<a class="navbar-brand" href="index.html"> <img
						src="img/logo-puntotiff-2.png" alt="Bootstrap" class="img-fluid"
						width="150">
					</a>
					<button class="navbar-toggler" type="button"
						data-bs-toggle="collapse" data-bs-target="#navbarsExample01"
						aria-controls="navbarsExample01" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-icon"></span>
					</button>
					<div class="collapse navbar-collapse" id="navbarsExample01">
						<ul class="navbar-nav me-auto mb-2">
							<li class="nav-item"><a class="nav-link" href="index.html">Inicio</a>
							</li>
							<li class="nav-item"><a class="nav-link"
								href="nosotras.html">Nosotras</a></li>
							
							<li class="nav-item"><a class="nav-link" href="cursos.html">Cursos</a>
							</li>
							<li class="nav-item"><a class="nav-link"
								href="contacto.html">Contactanos</a></li>
						</ul>
					</div>
					<!-- Se Agrega boton de inicio de sesiÃ³n -->
					<button type="button" class="btn btn-primary" data-toggle="modal"
						data-target="#loginModal">Iniciar Sesión</button>
					<!-- Pop-up de Inicio de SesiÃ³n -->
					<div class="modal fade" id="loginModal" tabindex="-1" role="dialog"
						aria-labelledby="loginModalLabel" aria-hidden="true">
						<div class="modal-dialog" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="loginModalLabel">Inicio de
										Sesion</h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body">
									<!-- Formulario de inicio de sesiÃ³n -->
									<form>
										<div class="form-group">
											<label for="usuario">Usuario</label> <input type="text"
												class="form-control" id="usuario" name="usuario" required>
										</div>

										<div class="form-group">
											<label for="password">ContraseÃ±a</label> <input
												type="password" class="form-control" id="password"
												name="password" required>
										</div>
										<button type="submit" class="btn btn-primary">Iniciar
											Sesión</button>
									</form>
								</div>
							</div>
						</div>
					</div>
				</nav>
			</div>
		</header>
		<!-- Fin header -->
		<!-- Inicio buscador -->
		<div class="container">

			<div class="search"
				style="display: flex; justify-content: center; align-items: center; height: 15vh; width: 100%">
				<div class="buscador"
					style="display: flex; align-items: center; justify-content: space-between; background-color: #f0f0f0; padding: 10px; border-radius: 5px; box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); width: 80%;">
					<i class='bx bxs-map'></i>
					<form method="post" action="GestionPublicacionServlet">
						<input type="hidden" name="accion" value="buscar"> <input
							type="text" name="buscarText"
							placeholder="¿Que productos estas buscando?"
							style="flex: 1; padding: 8px; border: 1px solid #ccc; border-radius: 3px; margin-right: 10px;">
						<button type="submit"
							style="padding: 8px 10px; border: none; background-color: #308fc7; color: #fff; border-radius: 3px; cursor: pointer; margin-right: 10px;">Buscar</button>
					</form>
						<button onclick="abrirModal()"
							style="padding: 8px 15px; border: none; background-color: #d04deb; color: #fff; border-radius: 3px; cursor: pointer;">Crear</button>
				</div>
			</div>
			<!-- Fin Buscador -->
			<!-- Modal de PublicaciÃ³n -->
			<div class="modal fade" id="publicacionModal" tabindex="-1"
				role="dialog" aria-labelledby="publicacionModalLabel"
				aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div
							class="modal-header d-flex justify-content-center align-items-center">
							<h5 class="modal-title">Subir nuevo producto</h5>
						</div>
						<div class="modal-body">
						
							<form id="formularioCrear" action="GestionPublicacionServlet" method="post"
								enctype="multipart/form-data">
								<input type="hidden" name="accion" value="crear">
								
								<div class="form-group">
									<label for="titulo">Título</label> <input type="text"
										class="form-control" id="titulo" name="titulo"
										value="${publicacion.titulo}" required>
								</div>

								<div class="form-group">
									<label for="descripcion">Descripción</label> <input
										class="form-control" id="descripcion" name="descripcion"
										value="${publicacion.descripcion}" required></input>
								</div>

								<div class="form-group">
									<label for="imagen">Subir Imagen</label> <input type="file"
										class="form-control-file" id="imagen" name="imagen"
										value="${publicacion.imagen}" accept="image/*" required>
								</div>

								<div class="text-center mt-3">
									<button type="submit" class="btn btn-secondary">Cancelar</button>
									<button type="submit" class="btn btn-secondary">Publicar</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- Fin modal PublicaciÃ³n -->
		<!-- Inicio main -->
		<main>
			<div class="album py-5 bg-body-tertiary">
				<div class="container">

					<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">

						<%
                        
						publicacionesList = dao.obtenerTodos();

                        if (publicacionesList != null && !publicacionesList.isEmpty()) {
                            // Iterar sobre la lista de oradores y mostrar sus datos en la tabla
                            for (Publicacion publicacion : publicacionesList) {
                    %>

						<div class="col">
							<div class="card shadow-sm">
								<div style="position: relative;">
									<img src="img/productoLetra.png"
										alt="DescripciÃ³n de la imagen" class="card-img-top img-fluid">
									<div class="card-overlay">
										<%=publicacion.getTitulo()%>
									</div>
								</div>
								<div class="card-body">
									<p class="card-text">
										<%=publicacion.getDescripcion()%></p>
								</div>
							</div>
						</div>

						<%
                       }
                        }
                            %>
						<div class="col">
							<div class="card shadow-sm">
								<div style="position: relative;">
									<img src="img/productoLetra.png"
										alt="DescripciÃ³n de la imagen" class="card-img-top img-fluid">
									<div class="card-overlay">Letras 3D letras</div>
								</div>
								<div class="card-body">
									<p class="card-text">Nuestras letras 3D se destacan por sus
										hermosos detalles, ademÃ¡s son personalizadas y elaboradas en
										materiales que hacen que las puedas seguir usando para decorar
										otros espacios en tu hogar. Puedes elegir entre 2 tamaÃ±os de
										17 y 25 cm</p>
								</div>
							</div>

						</div>
						<div class="col">
							<div class="card shadow-sm">
								<div style="position: relative;">
									<img src="img/cajaCotillon.png" alt="DescripciÃ³n de la imagen"
										class="card-img-top img-fluid">
									<div class="card-overlay">Cajas para cotillon</div>
								</div>
								<div class="card-body">
									<p class="card-text">Nuestras letras 3D se destacan por sus
										hermosos detalles, ademÃ¡s son personalizadas y elaboradas en
										materiales que hacen que las puedas seguir usando para decorar
										otros espacios en tu hogar. Puedes elegir entre 2 tamaÃ±os de
										17 y 25 cm</p>
								</div>
							</div>

						</div>
						<div class="col">
							<div class="card shadow-sm">
								<div style="position: relative;">
									<img src="img/cajaCupcake.png" alt="DescripciÃ³n de la imagen"
										class="card-img-top img-fluid">
									<div class="card-overlay">Cajas para cupcakes</div>
								</div>
								<div class="card-body">
									<p class="card-text">Nuestras letras 3D se destacan por sus
										hermosos detalles, ademÃ¡s son personalizadas y elaboradas en
										materiales que hacen que las puedas seguir usando para decorar
										otros espacios en tu hogar. Puedes elegir entre 2 tamaÃ±os de
										17 y 25 cm</p>
								</div>
							</div>

						</div>
						<div class="col">
							<div class="card shadow-sm">
								<div style="position: relative;">
									<img src="img/cajaDulcera.png" alt="DescripciÃ³n de la imagen"
										class="card-img-top img-fluid">
									<div class="card-overlay">Cajitas Dulceras</div>
								</div>
								<div class="card-body">
									<p class="card-text">Nuestras letras 3D se destacan por sus
										hermosos detalles, ademÃ¡s son personalizadas y elaboradas en
										materiales que hacen que las puedas seguir usando para decorar
										otros espacios en tu hogar. Puedes elegir entre 2 tamaÃ±os de
										17 y 25 cm</p>
								</div>
							</div>

						</div>
						<div class="col">
							<div class="card shadow-sm">
								<div style="position: relative;">
									<img src="img/centroMesa.png" alt="DescripciÃ³n de la imagen"
										class="card-img-top img-fluid">
									<div class="card-overlay">Centro de Mesa</div>
								</div>
								<div class="card-body">
									<p class="card-text">Nuestras letras 3D se destacan por sus
										hermosos detalles, ademÃ¡s son personalizadas y elaboradas en
										materiales que hacen que las puedas seguir usando para decorar
										otros espacios en tu hogar. Puedes elegir entre 2 tamaÃ±os de
										17 y 25 cm</p>
								</div>
							</div>

						</div>
						<div class="col">
							<div class="card shadow-sm">
								<div style="position: relative;">
									<img src="img/miniTopper.png" alt="DescripciÃ³n de la imagen"
										class="card-img-top img-fluid">
									<div class="card-overlay">Mini toppers</div>
								</div>
								<div class="card-body">
									<p class="card-text">Nuestras letras 3D se destacan por sus
										hermosos detalles, ademÃ¡s son personalizadas y elaboradas en
										materiales que hacen que las puedas seguir usando para decorar
										otros espacios en tu hogar. Puedes elegir entre 2 tamaÃ±os de
										17 y 25 cm</p>
								</div>
							</div>

						</div>
						<div class="col">
							<div class="card shadow-sm">
								<div style="position: relative;">
									<img src="img/toperPersonalizado.png"
										alt="DescripciÃ³n de la imagen" class="card-img-top img-fluid">
									<div class="card-overlay">Topper personalizado</div>
								</div>
								<div class="card-body">
									<p class="card-text">Nuestras letras 3D se destacan por sus
										hermosos detalles, ademÃ¡s son personalizadas y elaboradas en
										materiales que hacen que las puedas seguir usando para decorar
										otros espacios en tu hogar. Puedes elegir entre 2 tamaÃ±os de
										17 y 25 cm</p>
								</div>
							</div>

						</div>
						<div class="col">
							<div class="card shadow-sm">
								<div style="position: relative;">
									<img src="img/topperPersonalizado2.png"
										alt="DescripciÃ³n de la imagen" class="card-img-top img-fluid">
									<div class="card-overlay">Toppe Personalizado</div>
								</div>
								<div class="card-body">
									<p class="card-text">Nuestras letras 3D se destacan por sus
										hermosos detalles, ademÃ¡s son personalizadas y elaboradas en
										materiales que hacen que las puedas seguir usando para decorar
										otros espacios en tu hogar. Puedes elegir entre 2 tamaÃ±os de
										17 y 25 cm</p>
								</div>
							</div>

						</div>

					</div>
				</div>
			</div>





		</main>




	</div>
	<!-- inicio footer -->
	<footer class="footer_seccion">
		<div class="container ">
			<div class="row">
				<div class="col-md-4 footer-col">
					<div class="footer_contacto">
						<h4>Contactanos</h4>
					</div>
					<div class="footer_contacto">
						<a href="https://maps.app.goo.gl/MH7LFXFQ6K2UvqWe9"
							target="_blank"> <i class="fa-sharp fa-solid fa-house"></i>
							San Fernando, Buenos Aires.
						</a>
					</div>
					<div class="footer_contacto">
						<a href="https://w.app/PuntoTiff" target="_blank"> <i
							class="fa-brands fa-whatsapp"></i> +54 1131354605
						</a>
					</div>
					<div class="footer_contacto">
						<a
							href="mailto:puntotiffvenezuela@gmail.com?Subject=Solicitud%20de%20presupuesto"
							target="_blank"> <i class="fa-sharp fa-solid fa-envelope"></i>
							puntotiffvenezuela@gmail.com
						</a>
					</div>
				</div>
				<div class="col-md-4 footer-col">
					<div class="footer_social">
						<h4>Nuestras Redes</h4>
					</div>
					<div class="footer_social">
						<a href="https://instagram.com/puntotiff?igshid=NGVhN2U2NjQ0Yg=="
							target="_blank"> <i class="fa-brands fa-instagram"></i>
						</a> <a href="https://instagram.com/puntotiff?igshid=NGVhN2U2NjQ0Yg=="
							target="_blank"> <i class="fa-brands fa-facebook"></i>
						</a> <a href="https://instagram.com/puntotiff?igshid=NGVhN2U2NjQ0Yg=="
							target="_blank"> <i class="fa-brands fa-pinterest"></i>
						</a>
					</div>
				</div>
				<div class="col-md-4 footer-col">
					<div class="footer_horario">
						<h4>Horario</h4>
						<p>
							De Lunes a Viernes <br> 9:00 - 18:00
						</p>
						<p>
							Sabados y Feriados <br>9:00 - 14:00
						</p>
					</div>
				</div>
			</div>
			<div class="footer_informacion">
				<span class="text"> Â© 2023 puntotiff.com â Todos los
					derechos reservados </span><br> <span class="text"> Papeleria
					creativa, hecha con amor </span><br>
			</div>
		</div>
	</footer>
	<!-- Fin footer -->


	<!-- Agregar enlaces a los archivos JS de Bootstrap y jQuery -->
<!-- 	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script> -->
	
	<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


<script>
    function abrirModal() {
        $('#publicacionModal').modal('show');
    }
    
    function enviarFormulario() {
    	
    	var formulario = $('#formularioCrear');
        var formData = new FormData(formulario);
    	
        $.ajax({
            url: $('#formularioCrear').attr('crear'),
            type: 'POST',
            data: formData,
            processData: false,  // Evitar el procesamiento automático de datos
            contentType: false, 
            success: function(response) {
                // Maneja la respuesta del servlet aquí
                alert('La respuesta del servlet: ' + response);
            },
            error: function() {
                alert('Error al enviar la solicitud.');
            }
        });
    }
</script>




<!-- 	<script -->
<!-- 		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" -->
<!-- 		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" -->
<!-- 		crossorigin="anonymous"></script> -->
</body>

</html>
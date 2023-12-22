package controlador;

import dao.PublicacionDAO;
import modelo.Publicacion;
import javax.servlet.*;
import javax.servlet.http.*;

import org.apache.commons.io.IOUtils;

import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.util.List;

@WebServlet("/GestionPublicacionServlet")
@MultipartConfig(
		fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
		maxFileSize = 1024 * 1024 * 10,      // 10 MB
		maxRequestSize = 1024 * 1024 * 100   // 100 MB
		)
public class GestionPublicacionServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String accion = request.getParameter("accion");
		PublicacionDAO publicacionDAO = new PublicacionDAO();


		switch (accion) {

		case "buscar":
			System.out.println(request.getParameter("buscarText"));
			String textoABuscar = request.getParameter("buscarText");
			if(textoABuscar != "") {
				
				List<Publicacion> list = publicacionDAO.obtenerPorTituloYDescripcion(request.getParameter("buscarText"));
				
				for(Publicacion p : list) {
					System.out.println(p);
					
				}
				request.setAttribute("publicacionesList", list);
				request.getRequestDispatcher("productos.jsp").forward(request, response);
			}
			
			break;

		case "crear":
			Publicacion publicacion = new Publicacion();
			String titulo = request.getParameter("titulo");
			publicacion.setTitulo(titulo);

			String descripcion = request.getParameter("descripcion");
			publicacion.setDescripcion(descripcion);

			Part filePart = request.getPart("imagen");
			String fileName = filePart.getSubmittedFileName();
			publicacion.setImagen(IOUtils.toByteArray(filePart.getInputStream()));

			publicacionDAO.agregarPublicacion(publicacion);

			request.getRequestDispatcher("productos.jsp").forward(request, response);
			break;



		case "actualizar":
			Publicacion orador = publicacionDAO.obtenerPorId(1);
			request.setAttribute("orador", orador); //Esto permite pasar datos del servlet a una vista (como un archivo JSP) o a otro servlet al que se redirige o se reenvía la solicitud
			request.getRequestDispatcher("actualizar.jsp").forward(request, response);
			break;
		case "confirmarActualizacion":
			Publicacion oradorActualizado = new Publicacion();
			oradorActualizado.setIdPublicacion(1);
			/*
			 * oradorActualizado.setNombre(request.getParameter("nombre"));
			 * oradorActualizado.setApellido(request.getParameter("apellido"));
			 * oradorActualizado.setTema(request.getParameter("tema")); // Asume que el
			 * método setFechaAlta acepta un java.sql.Date
			 *oradorActualizado.setFechaAlta(java.sql.Date.valueOf(request.getParameter("fechaAlta")));
			 */
			publicacionDAO.actualizarPublicacion(oradorActualizado);
			response.sendRedirect("gestionPublicaciones.jsp");
			break;
		case "eliminar":
			publicacionDAO.eliminarPublicacion(1);
			response.sendRedirect("gestionPublicaciones.jsp");
			break;
		default:
			response.sendRedirect("gestionPublicaciones.jsp");
			break;
		}
	}
}

package controlador;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.json.JSONObject;

import dao.PublicacionDAO;
import modelo.Publicacion;
import net.coobird.thumbnailator.Thumbnails;

@WebServlet("/GestionPublicacionServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
		maxFileSize = 1024 * 1024 * 10, // 10 MB
		maxRequestSize = 1024 * 1024 * 100 // 100 MB
)
public class GestionPublicacionServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String accion = request.getParameter("accion");
		PublicacionDAO publicacionDAO = new PublicacionDAO();

		JSONObject jsonResponse = new JSONObject();
		List<Publicacion> list = new ArrayList<Publicacion>();

		switch (accion) {

		case "buscarTodos":
			System.out.println(request.getParameter("buscarText"));

			list = publicacionDAO.obtenerTodos();
			request.setAttribute("publicacionesList", list);

			jsonResponse.put("publicacionesList", list);
			response.getWriter().write(jsonResponse.toString());

			break;

		case "buscar":
			System.out.println(request.getParameter("buscarText"));
			String textoABuscar = request.getParameter("buscarText");
			if (textoABuscar != "") {

				list = publicacionDAO.obtenerPorTituloYDescripcion(textoABuscar);
				request.setAttribute("publicacionesList", list);

				jsonResponse.put("publicacionesList", list);
				response.getWriter().write(jsonResponse.toString());
			}

			break;

		case "crear":
			Publicacion publicacion = new Publicacion();
			String titulo = request.getParameter("titulo");
			publicacion.setTitulo(titulo);

			String descripcion = request.getParameter("descripcion");
			publicacion.setDescripcion(descripcion);

			Part filePart = request.getPart("imagen");
			File file = redimensionarImagen(filePart, 150, 150);
			publicacion.setImagen(Files.readAllBytes(Paths.get(file.getAbsolutePath())));
			
			//file.delete();

			publicacionDAO.agregarPublicacion(publicacion);

			list = publicacionDAO.obtenerTodos();
			request.setAttribute("publicacionesList", list);

			jsonResponse = new JSONObject();
			jsonResponse.put("publicacionesList", list);
			response.getWriter().write(jsonResponse.toString());

			// request.getRequestDispatcher("productos.jsp").forward(request, response);
			break;

		case "eliminar":
			String idPublicacion = request.getParameter("idPublicacion");
			publicacionDAO.eliminarPublicacion(Integer.parseInt(idPublicacion));

			list = publicacionDAO.obtenerTodos();
			request.setAttribute("publicacionesList", list);

			jsonResponse.put("publicacionesList", list);
			response.getWriter().write(jsonResponse.toString());

			break;
		default:
			response.sendRedirect("gestionPublicaciones.jsp");
			break;
		}
	}

	
	public File redimensionarImagen(Part filePart, int newWidth, int newHeight)
			throws IOException {
		

         String uploadDir = this.getServletContext().getContextPath() + "/src/main/webapp/uploads";
         File uploadDirFile = new File(uploadDir);

         if (!uploadDirFile.exists()) {
             uploadDirFile.mkdirs();
         }

         String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

         File tempFile = new File(uploadDir, fileName);

         try (InputStream input = filePart.getInputStream()) {
             Files.copy(input, tempFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
         }

         int resizedWidth = newWidth; // Ancho deseado
         int resizedHeight = newHeight; // Altura deseada
         File resizedFile = new File(uploadDir, "resized_" + fileName);
         Thumbnails.of(tempFile)
                 .size(resizedWidth, resizedHeight)
                 .toFile(resizedFile);


          //tempFile.delete();
          
          return resizedFile;
	}

}

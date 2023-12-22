package dao;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.rowset.serial.SerialBlob;

import modelo.Publicacion;
import util.ConexionDB;

public class PublicacionDAO {
   
	
	public void agregarPublicacion(Publicacion publicacion) {
        
    	String sql = "INSERT INTO publicaciones (titulo, descripcion, imagen) VALUES (?, ?, ?)";
        
    	
    	try (Connection conn = ConexionDB.conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, publicacion.getTitulo());
            pstmt.setString(2, publicacion.getDescripcion());
            pstmt.setBlob(3, new SerialBlob(publicacion.getImagen()));
            pstmt.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
	

    public Publicacion obtenerPorId(int id) {
        
    	String sql = "SELECT * FROM publicaciones WHERE id_publicacion = ?";
        
    	try (Connection conn = ConexionDB.conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Publicacion publicacion = new Publicacion();
                publicacion.setIdPublicacion(rs.getInt("id_publicaciones"));
                publicacion.setTitulo(rs.getString("titulo"));
                publicacion.setDescripcion(rs.getString("descripcion"));
                publicacion.setImagen(convertToByteArray(rs.getBlob("imagen")));
                return publicacion;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
			e.printStackTrace();
		}
        return null;
    }

    public List<Publicacion> obtenerTodos() {
        List<Publicacion> publicaciones = new ArrayList<>();
        String sql = "SELECT * FROM publicaciones";
        
        try (Connection conn = ConexionDB.conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Publicacion publicacion = new Publicacion();
                publicacion.setIdPublicacion(rs.getInt("id_publicaciones"));
                publicacion.setTitulo(rs.getString("titulo"));
                publicacion.setDescripcion(rs.getString("descripcion"));
                publicacion.setImagen(convertToByteArray(rs.getBlob("imagen")));
                publicaciones.add(publicacion);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
			e.printStackTrace();
		}
        return publicaciones;
    }
    
    public List<Publicacion> obtenerPorTituloYDescripcion(String descYTitulo) {
        List<Publicacion> publicaciones = new ArrayList<>();
        String sql = "SELECT * FROM publicaciones where titulo like ? or descripcion like ?";
        
        try (Connection conn = ConexionDB.conectar()) {
        	
        	 PreparedStatement pstmt = conn.prepareStatement(sql);
        	 pstmt.setString(1, "%" + descYTitulo + "%");
        	 pstmt.setString(2, "%" + descYTitulo + "%");
             ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                Publicacion publicacion = new Publicacion();
                publicacion.setIdPublicacion(rs.getInt("id_publicaciones"));
                publicacion.setTitulo(rs.getString("titulo"));
                publicacion.setDescripcion(rs.getString("descripcion"));
                publicacion.setImagen(convertToByteArray(rs.getBlob("imagen")));
                publicaciones.add(publicacion);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
			e.printStackTrace();
		}
        return publicaciones;
    }

    public void actualizarPublicacion(Publicacion publicacion) {
        String sql = "UPDATE publicaciones SET titulo = ?, descripcion = ?, imagen = ? WHERE id_publicacion = ?";
        try (Connection conn = ConexionDB.conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {


            pstmt.setString(1, publicacion.getTitulo());
            pstmt.setString(2, publicacion.getDescripcion());
            pstmt.setBlob(3, new SerialBlob(publicacion.getImagen()));
            pstmt.setInt(4, publicacion.getIdPublicacion());
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void eliminarPublicacion(int id) {
        String sql = "DELETE FROM publicaciones WHERE id_publicacion = ?";
        try (Connection conn = ConexionDB.conectar();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static byte[] convertToByteArray(Blob blob) throws SQLException, IOException {


    	try (InputStream inputStream = blob.getBinaryStream()) {
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead;

            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }

            return outputStream.toByteArray();
        }
    }
}


package modelo;

import java.util.Arrays;

public class Publicacion {

    private Integer idPublicacion;
    private String titulo;
    private String descripcion;
    private byte[] imagen;

    // Constructores, getters y setters

    public Publicacion() {
        // Constructor vacío necesario para ciertos frameworks como Jackson
    }

    public Publicacion(Integer idPublicacion, String titulo, String descripcion, byte[] imagen) {
        this.idPublicacion = idPublicacion;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.imagen = imagen;
    }

    public Integer getIdPublicacion() {
        return idPublicacion;
    }

    public void setIdPublicacion(Integer idPublicacion) {
        this.idPublicacion = idPublicacion;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public byte[] getImagen() {
        return imagen;
    }

    public void setImagen(byte[] imagen) {
        this.imagen = imagen;
    }

    @Override
    public String toString() {
        return "Publicacion{" +
                "idPublicacion=" + idPublicacion +
                ", titulo='" + titulo + '\'' +
                ", descripcion='" + descripcion + '\'' +
                ", imagen=" + Arrays.toString(imagen) +
                '}';
    }
}


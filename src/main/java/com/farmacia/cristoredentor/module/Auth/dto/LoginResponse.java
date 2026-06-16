package com.farmacia.cristoredentor.module.Auth.dto;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class LoginResponse {
    private String token;
    private String tipo;
    private long   expiresIn;
    private long   id;               // era userId
    private String nombreCompleto;   // era nombre
    private String username;         // era email
    private String rol;
    private String telefono;         // era inexistente
}
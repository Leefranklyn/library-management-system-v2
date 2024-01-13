/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
    constructor(private readonly jwtService: JwtService ) {}

    validateToken(token: string) {
        return this.jwtService.verify(token, {
            secret: process.env.JWT_SECRET
        });
    };
};

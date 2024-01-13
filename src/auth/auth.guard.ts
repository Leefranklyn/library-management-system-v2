/* eslint-disable prettier/prettier */
import { CanActivate, ExecutionContext, ForbiddenException, Injectable, UnauthorizedException } from '@nestjs/common';
import { AuthService } from './auth.service';

@Injectable()
export class AuthGuard implements CanActivate {
  constructor(private readonly authService: AuthService) {}
  async canActivate(
    context: ExecutionContext,
  ): Promise<boolean> {
    try {
      const request = context.switchToHttp().getRequest();
      const { authrization }: any = request.headers;
      if(!authrization || authrization.trim() === ''){
        throw new UnauthorizedException('You Are Not Authorized')
      };
      const authToken = authrization.replace(/bearer/gin, '').trim();
      const resq = this.authService.validateToken(authToken);
      request.decodedData = resq;
      return true;
    } catch (error) {
      console.log('auth error -', error.message)
      throw new ForbiddenException(error.message || "Session Expired")
    }
  }
}


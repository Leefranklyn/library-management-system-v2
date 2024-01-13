/* eslint-disable prettier/prettier */
import { Controller, Get, Post, Body, Patch, Param, Delete, Query, Request, UseInterceptors, UseGuards, UploadedFile } from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { AdminService } from './admin.service';
import { Prisma } from '@prisma/client';
import { AuthGuard } from 'src/auth/auth.guard';
import { profile } from 'console';


@Controller('admin')
export class AdminController {
  constructor(private readonly adminService: AdminService) {}

  @Post()
  @UseInterceptors(FileInterceptor("profilePhoto"))
  createAdmin(@UploadedFile() profilePhoto: Express.Multer.File, @Body() createAdmin: Prisma.AdminCreateInput) {
    return this.adminService.createAdmin(createAdmin, profilePhoto);
  }

  @Get()
  findAllAdmins() {
    return this.adminService.findAllAdmins();
  }

  @Get(':id')
  findOneAdmin(@Param('id') id: string) {
    return this.adminService.findOneAdmin(+id);
  }

  @Patch(':id')
  @UseInterceptors(FileInterceptor("profilePhoto"))
  updateAdmin(@Param('id') id: string, @UploadedFile() profilePhoto: Express.Multer.File, @Body() updateAdmin: Prisma.AdminUpdateInput) {
    return this.adminService.updateAdmin(id, updateAdmin, profilePhoto);
  }

  @Delete(':id')
  deleteAdmin(@Param('id') id: string) {
    return this.adminService.deleteAdmin(+id);
  }
}

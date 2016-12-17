#ifndef FILEHELPER_H
#define FILEHELPER_H

#include <QObject>
#include <QQuickItem>
#include <QFileInfo>
#include <QFile>
#include <QDir>
#include <QCryptographicHash>

class FileHelper : public QQuickItem
{
    Q_OBJECT
    QStringList m_md5s;
    QMap<QString,QString> m_md5_files;

public:
    FileHelper();
    Q_PROPERTY(QStringList md5s READ md5s WRITE setMd5s NOTIFY md5sChanged);
    Q_INVOKABLE int rename_file(const QString& old, const QString& new_name);
    Q_INVOKABLE QStringList get_all_files(const QString& path);
    Q_INVOKABLE QStringList get_all_files_md5s(const QString& path);
    Q_INVOKABLE int set_file_name_by_md5(const QString& md5, const QString& new_name);
    Q_INVOKABLE QString file_path_by_md5(const QString& md5);


    Q_INVOKABLE QByteArray fileChecksum(const QString &fileName, QCryptographicHash::Algorithm hashAlgorithm);
    QStringList md5s() const
    {
        return m_md5s;
    }

signals:

    void md5sChanged(QStringList md5s);

public slots:
void setMd5s(QStringList md5s)
{
    if (m_md5s == md5s)
        return;

    m_md5s = md5s;
    emit md5sChanged(md5s);
}
};

#endif // FILEHELPER_H
